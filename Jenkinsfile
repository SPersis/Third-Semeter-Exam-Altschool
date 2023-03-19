pipeline {
    agent any
    environment {
        env = "production"
    }

    stages {
        stage('git clone') {
            steps {
                git branch: 'master', url: 'https://github.com/SPersis/microservices-demo.git'
            }
        }
        stage('Deploy socks application') {
            steps {
                dir('deploy/kubernetes') {
                    sshagent(['SSH']){
                        sh "scp -o strictHostKeyChecking=no complete-demo.yaml ubuntu@54.159.20.135:/home/ubuntu"
                    }
                    script {
                        try{
                            sh "ssh ubuntu@54.159.20.135 kubectl apply -f complete-demo.yaml"
                        } catch(error){
                            sh "ssh ubuntu@54.159.20.135 kubectl create -f complete-demo.yaml"
                        }
                    }
                }
            }
        }
         stage ('Git clone Omnifood') {
            steps('git clone') {
                git branch: 'main', url: 'https://github.com/SPersis/Third-Semeter-Exam-Altschool'
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
        stage('Prometheus and Granfana Deployment') {
            steps {
                dir('deploy/kubernetes') {
                    sshagent(['SSH']) {
                        sh "scp -o strictHostKeyChecking=no -r manifests-monitoring ubuntu@54.159.20.135:/home/ubuntu"

                        script {
                            try {
                                sh "ssh ubuntu@54.159.20.135 kubectl create -f manifests-monitoring/00-monitoring-ns.yaml"
                            } catch(error) {
                                sh "ssh ubuntu@54.159.20.135 kubectl apply -f manifests-monitoring/00-monitoring-ns.yaml"
                            }
                        }
                    }
                }
            }
        }
    }
}
