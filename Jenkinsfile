pipeline {
    agent any
    environment {
        tag = sh(returnStdout: true, script: "git rev-parse --short HEAD").trim()
    }
    
    stages {
        stage("Build Website"){
            agent {
                    label "testing"
                }
            steps {
                git 'https://github.com/sakthinatural/website.git'
                sh "sudo docker build  . -t sakthinatural123/webimage:${tag}"
                
            }
        }

        stage('Push to Docker Hub') {
            agent {
                label "testing"
            }
            steps {
                withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerpwd')]) {
                    sh 'sudo docker login -u sakthinatural123 -p ${dockerpwd}'
                    sh "sudo docker push sakthinatural123/webimage:${tag}"
                 }  
                
            }
            
        }
        stage('Push to Test server') {
            agent {
                label "testing"
            }
            steps {
                withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerpwd')]) {
                    sh 'sudo docker login -u sakthinatural123 -p ${dockerpwd}'
                    sh "sudo docker rm -f $(docker ps -a -q)"
                    sh "docker rmi -f $(docker images -a -q)"
                    sh "sudo docker pull sakthinatural123/webimage:${tag}"
                    sh "sudo docker run -it -d -P sakthinatural123/webimage:${tag}" 
                }
            }
        }

        stage('Push to Production server') {
            agent {
                label "production"
            }
            steps {
                withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerpwd')]) {
                    sh 'sudo docker login -u sakthinatural123 -p ${dockerpwd}'
                    sh "sudo docker rm -f $(docker ps -a -q)"
                    sh "docker rmi -f $(docker images -a -q)"
                    sh "sudo docker pull sakthinatural123/webimage:${tag}"
                    sh "sudo docker run -it -d -P sakthinatural123/webimage:${tag}" 
                }
            }
        }
        
        
        
        
       
        
    }
}   
