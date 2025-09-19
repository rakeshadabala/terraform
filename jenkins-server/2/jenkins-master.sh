#!/bin/bash
set -e

sudo -i

apt-get update

apt-get install -y openjdk-17-jdk gnupg curl git

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

apt-get update
apt-get install -y jenkins

systemctl enable jenkins
systemctl start jenkins


#sudo cat  /var/lib/jenkins/secrets/initialAdminPassword 