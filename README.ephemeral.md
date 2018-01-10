# SonarQube on OpenShift (Ephemeral)

This is an ephemeral version of [SonarQube on Openshift (Persistent)](README.md). Be aware that all changes will be lost when a pod is restarted.

The `sonarqube-ephemeral` template will create a SonarQube application

## Install SonarQube

A template has been defined including the required elements like `Route`, `Service` and so forth. In order to create the elements it doesn’t necessarily need to be created, just processed but for the sake of reusability I have preferred the creation over the processing.
```
$ oc create -f ocp-resources/sonarqube-ephemeral-template.yaml -n openshift
template "sonarqube-ephemeral" created
```
Once created it can be used to create a new application with the default values:
```
$  oc new-app sonarqube-persistent
--> Deploying template "sonardemo/sonarqube-ephemeral" to project sonardemo

     SonarQube (Ephemeral)
     ---------
     Sonarqube service, with ephemeral storage.

     NOTE: Data will not be persistent across restarts

     A Sonarqube service has been created in your project.

     * With parameters:
        * SonarQube Service Name=sonar
        * Data Volume Capacity=256Mi
        * Extensions Volume Capacity=256Mi

--> Creating resources ...
    route "sonar" created
    deploymentconfig "sonar" created
    service "sonar" created
--> Success
    Access your application via route 'sonar-sonardemo.apps.example.com'
    Run 'oc status' to view your app.
```

## Checkpoint
At this stage, all three pods should be running and healthy.
```
$ oc get pods
NAME                 READY     STATUS    RESTARTS   AGE
sonar-1-snkms        1/1       Running   0          27m
```
Besides, it should be possible to access SonarQube:

    http://sonar-sonardemo.apps.example.com
