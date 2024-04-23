#FROM java:8
#
#
#EXPOSE 8080
#
#ADD target/userservice.jar userservice.jar
#
#ENTRYPOINT ["java" , "-jar" , "/userservice.jar"]

# Use an official OpenJDK 8 runtime as a parent image
FROM openjdk:8-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the jar file into the container at /app
COPY target/userservice.jar /app/userservice.jar

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "/app/userservice.jar"]
