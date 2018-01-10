# SonarQube on OpenShift (Persistent)

**NOTE: For the ephemeral deployment refer to [SonarQube on OpehShift (Ephemeral)](README.ephemeral.md)**

The `sonarqube-postgresql` template will create a SonarQube and PostgreSQL applications

## Create all the Persistent Volumes
**Note:** I have used `hostPath` for simplicity but any other solution should be fine as well. A convenience ServiceAccount called `sonar` is created in case it is needed to run as anyuid (depending on the persistence configuration)

## Install SonarQube
First the Persistent volumes have to be created:
* postgresql-volume: To be used by PostgreSQL server

```
$ oc create -f ocp-resources/postgresql-pv.yaml
persistentvolume "postgresql-volume" created
```
* sonar-data-volume: Contains all the data related to the web application and Elasticsearch
* sonar-extensions-volume: Persists all the installed extensions/plugins

```
$ oc create -f ocp-resources/sonar-pv.yaml
persistentvolume "sonar-data-volume" created
persistentvolume "sonar-extensions-volume" created
```

A template has been defined including the required elements like `ServiceAccount`, `PersitentVolumeClaim`, `Route`, `Service`, `Secret`, `DeploymentConfig` for deploying both SonarQube and PostgreSQL. In order to create the elements it doesn’t necessarily need to be created, just processed but for the sake of reusability I have preferred the creation over the processing.
```
$ oc create -f ocp-resources/sonarqube-postgresql-template.yaml -n openshift
template "sonarqube-postgresql" created
```
Once created it can be used to create a new application with the default values:
```
$  oc new-app sonarqube-postgresql
--> Deploying template "sonardemo/sonarqube-postgresql" to project sonardemo

     SonarQube PostgreSQL (Persistent)
     ---------
     Sonarqube service, with PostgreSQL persistent storage.

     NOTE: You must have persistent volumes available in your cluster to use this template.

     A Sonarqube service has been created in your project. You can access using admin/admin.

     * With parameters:
        * SonarQube Service Name=sonar
        * Data Volume Capacity=256Mi
        * Extensions Volume Capacity=256Mi
        * Memory Limits=2Gi
        * PostgreSQL Username=sonarbwDs # generated
        * PostgreSQL Password=QwqgcypemxsNAXLo # generated
        * PostgreSQL Volume Capacity=1Gi
        * PostgreSQL Memory Limit=512Mi
        * Version of PostgreSQL Image=9.5
        * Namespace=openshift

--> Creating resources ...
    route "sonar" created
    persistentvolumeclaim "sonar-data" created
    persistentvolumeclaim "sonar-extensions" created
    deploymentconfig "sonar" created
    serviceaccount "sonar" created
    service "sonar" created
    secret "sonar-postgresql" created
    service "sonar-postgresql" created
    persistentvolumeclaim "sonar-postgresql" created
    deploymentconfig "sonar-postgresql" created
--> Success
    Access your application via route 'sonar-sonardemo.apps.example.com'
    Run 'oc status' to view your app.
```

## Checkpoint
At this stage, all three pods should be running and healthy.
```
$ oc get pods
NAME                       READY     STATUS        RESTARTS   AGE
sonar-1-sgjmv              1/1       Running       0          21m
sonar-postgresql-1-vtlpc   1/1       Running       0          21m

```
Besides, it should be possible to access SonarQube:

    http://sonar-sonardemo.apps.example.com
