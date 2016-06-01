FROM jboss/base-jdk:8
MAINTAINER Erik Jacobs <erikmjacobs@gmail.com>

ENV SONAR_VERSION=5.5 \
    SONARQUBE_HOME=/opt/jboss/sonarqube

USER root
EXPOSE 9000
ADD root /
RUN cd /tmp \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && cd /opt/jboss \
    && unzip /tmp/sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm /tmp/sonarqube.zip*
COPY run.sh $SONARQUBE_HOME/bin/
RUN /usr/bin/fix-permissions /opt/jboss/sonarqube \
    && chmod 775 $SONARQUBE_HOME/bin/run.sh
USER jboss
WORKDIR $SONARQUBE_HOME
ENTRYPOINT ["./bin/run.sh"]
