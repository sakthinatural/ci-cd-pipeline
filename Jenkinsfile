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
                sh "sudo docker build --pull --no-cache . -t sakthinatural123/customImage:${tag}"
                
            }
        }

        stage('Push to Docker Hub') {
            agent {
                label "testing"
            }
            steps {
                withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerpwd')]) {
                    sh 'sudo docker login -u sakthinatural123 -p ${dockerpwd}'
                    sh "sudo docker push sakthinatural123/customImage:${tag}"
                 }  
                
            }
            
        }
        stage('Push to Test server') {
            agent {
                label "testing"
            }
            steps {
                sh "sudo docker builder prune -af"
                sh "sudo docker run -it -d -P sakthinatural123/customImage:${tag}" 
            }
        }

        stage('Push to Production server') {
            agent {
                label "production"
            }
            steps {
                sh "sudo docker builder prune -af"
                sh "sudo docker run -it -d -P sakthinatural123/customImage:${tag}" 
            }
        }
        
        
        
        
       
        
    }
}   
