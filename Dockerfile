FROM openjdk:11-jre
COPY target/*.jar /app/application.jar
CMD ["java", "-jar", "application.jar"]
