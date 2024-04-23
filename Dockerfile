## Use an official OpenJDK 8 runtime as a parent image
#FROM openjdk:8-jdk-alpine
#
## Set the working directory in the container
#WORKDIR /app
#
## Copy the jar file into the container at /app
#COPY target/userservice.jar /app/userservice.jar
#
## Make port 8080 available to the world outside this container
#EXPOSE 8080
#
## Run the jar file
#ENTRYPOINT ["java", "-jar", "/app/userservice.jar"]

# Stage 1: Build the JAR file using Maven
FROM maven:3.6.3-openjdk-8-slim AS build
WORKDIR /workspace

# Copy the Maven pom.xml file first (for better caching)
COPY pom.xml .

# Download all required dependencies into one layer
RUN mvn dependency:go-offline -B

# Copy your source code into the image
COPY src src

# Package your application into a JAR file
RUN mvn clean package -DskipTests

# Stage 2: Setup the Java environment
FROM openjdk:8-jdk-alpine

WORKDIR /app

# Copy only the JAR from the build stage to the final image
COPY --from=build /workspace/target/userservice.jar /app/userservice.jar

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "/app/userservice.jar"]

