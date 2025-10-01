#!/bin/bash

sudo apt update
sudo apt install openjdk-21-jdk -y
java -version
sudo apt install Docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo apt install nginx -y

# cat > Dockerfile << 'EOF'
# FROM openjdk:21-slim
# RUN apt update -y 
# RUN apt install maven -y && apt install git -y
# WORKDIR /app
# RUN git clone https://github.com/spring-projects/spring-petclinic.git 
# RUN cd /app/spring-petclinic && mvn package -DskipTests
# EXPOSE 8080
# CMD ["java" ,"-jar", "/app/spring-petclinic/target/spring-petclinic-3.5.0-SNAPSHOT.jar"]
# EOF
echo "building the image"
sudo docker build -t venki:v8 .

sleep 10

echo "containerization"
sudo docker run -d -p 9000:8080  --name venkat-container venki:v8

sleep 10

echo "container status"
sudo docker ps

echo "container logs"
sudo docker logs  venkat-container

echo "Deployment Completed"













