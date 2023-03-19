#!/bin/bash

# install jenkins

sudo yum update
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins


        stage ('Git clone Omnifood') {
            steps('git clone') {
                git branch: 'main', url: 'https://github.com/SPersis/My-build.git'
            }
        }

        stage ('Deploy Omnifood') {
            steps {
                dir('Terraform-Ansible') {
                    sshagent(['SSH']){
                        sh "scp -o strictHostKeyChecking=no deployment.yml ubuntu@54.159.20.135:/home/ubuntu"
                    }
                    script {
                        try{
                            sh "ssh ubuntu@54.159.20.135 kubectl create -f deployment.yml"
                        } catch(error){
                            sh "ssh  ubuntu@54.159.20.135 kubectl apply -f deployment.yml"
                        }
                    }
                }
            }
        }
