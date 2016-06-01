# SonarQube on OpenShift
This repo contains all of the resources required to build an OpenShift-specific
Docker image of SonarQube.

It is inspired by the upstream SonarQube Docker image:
https://github.com/SonarSource/docker-sonarqube/tree/master/5.5

## Quick usage
You can do something like the following, assuming you are in an existing
OpenShift project:

    oc new-app postgresql-ephemeral \
    -p POSTGRESQL_USER=sonar,POSTGRESQL_PASSWORD=sonar,POSTGRESQL_DATABASE=sonar
    oc new-app docker.io/thoraxe/sonarqube:5.5 \
    -e SONARQUBE_JDBC_USERNAME=sonar,SONARQUBE_JDBC_PASSWORD=sonar,SONARQUBE_JDBC_URL=jdbc:postgresql://postgresql/sonar
    oc expose service sonarqube

This will result in your OpenShift environment deploying the included PostgreSQL
database with ephemeral storage and then deploying the SonarQube image directly
from DockerHub.

## ToDos
* Write an OpenShift template
* Add readiness and liveness probes
