FROM ubuntu:latest
RUN apt update -y 
RUN apt install maven -y && apt install git -y
RUN apt install openjdk-21-jdk -y
WORKDIR /app
ADD https://github.com/devopswithcloud/spring-petclinic.git  /app
RUN mvn clean package -DskipTests 
EXPOSE 8080
CMD ["java" ,"-jar", "/app/target/spring-petclinic-2.6.0-SNAPSHOT.jar"]
