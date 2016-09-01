FROM jboss/base-jdk:8
MAINTAINER Erik Jacobs <erikmjacobs@gmail.com>

ENV SONAR_VERSION=6.0 \
    SONARQUBE_HOME=/opt/sonarqube

USER root
EXPOSE 9000
ADD root /
RUN cd /tmp \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && cd /opt \
    && unzip /tmp/sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm /tmp/sonarqube.zip*
COPY run.sh $SONARQUBE_HOME/bin/

RUN useradd -r sonar
RUN /usr/bin/fix-permissions /opt/sonarqube \
    && chmod 775 $SONARQUBE_HOME/bin/run.sh

USER sonar
WORKDIR $SONARQUBE_HOME
ENTRYPOINT ["./bin/run.sh"]
