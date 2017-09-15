# SonarQube on OpenShift
This repo contains all of the resources required to build an OpenShift-specific
Docker image of SonarQube.

It is inspired by the upstream SonarQube Docker image:
https://github.com/SonarSource/docker-sonarqube/tree/master/6.5

## Quick usage
You can do something like the following, assuming you are in an existing
OpenShift project:

    oc new-app docker.io/openshiftdemos/sonarqube:6.5
    oc expose service sonarqube

This will result in your OpenShift environment deploying the embedded SQLite
database with ephemeral storage and then deploying the SonarQube image directly
from DockerHub.

## ToDos
* Write an OpenShift template
* Add readiness and liveness probes
