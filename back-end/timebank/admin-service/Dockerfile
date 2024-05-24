FROM --platform=linux/amd64 openjdk:17-jdk
#FROM openjdk:17-jdk

LABEL maintainer="ytjdud01@kookmin.ac.kr"

VOLUME /dev-admin-service

EXPOSE 8081

ARG JAR_FILE=build/libs/admin-service-0.0.1-SNAPSHOT.jar

COPY ${JAR_FILE} admin-springboot.jar

ENTRYPOINT ["java", "-jar","/admin-springboot.jar"]