# Stage 1: Build the application
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install

# Stage 2: Create the runtime image
FROM registry.access.redhat.com/ubi8/ubi-minimal:8.5
LABEL JAVA_VERSION="11"

RUN microdnf install --nodocs java-11-openjdk-headless && microdnf clean all

WORKDIR /work/
COPY --from=build /app/target/*.jar /work/application.jar

EXPOSE 8080
CMD ["java", "-jar", "application.jar"]
