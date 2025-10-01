#!/bin/bash
sudo apt-get update

sudo apt-get install -y openjdk-17-jdk gnupg curl git

sudo curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
sudo echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins

#sleep 10 seconds
sleep 10s

sudo echo "Jenkins initial admin password:"

#sudo cat  /var/lib/jenkins/secrets/initialAdminPassword 