FROM --platform=linux/amd64 openjdk:17-jdk
#FROM openjdk:17-jdk

LABEL maintainer="ytjdud01@kookmin.ac.kr"

VOLUME /dev-exchange-service

EXPOSE 8000

ARG JAR_FILE=build/libs/exchange-service-0.0.1-SNAPSHOT.jar

COPY ${JAR_FILE} exchange-springboot.jar

ENTRYPOINT ["java", "-jar","/exchange-springboot.jar"]