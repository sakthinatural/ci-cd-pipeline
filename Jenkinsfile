pipeline {
    agent any
    
    stages {
        stage("Build Website"){
            agent {
                    label "testing"
                }
            steps {
                git 'https://github.com/sakthinatural/website.git'
                sh "sudo docker build . -t sakthinatural123/testing:latest"
                
            }
        }

        stage('Push to Docker Hub') {
            agent {
                label "testing"
            }
            steps {
                withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerpwd')]) {
                    sh 'sudo docker login -u sakthinatural123 -p ${dockerpwd}'
                    sh "sudo docker push sakthinatural123/testing:latest"
                 }  
                
            }
            
        }
        stage('Push to Test server') {
            agent {
                label "testing"
            }
            steps {
                sh "sudo docker run -it -d -8080:80 sakthinatural123/testing:latest" 
            }
        }

        stage('Push to Production server') {
            agent {
                label "production"
            }
            steps {
                sh "sudo docker run -it -d -8080:80 sakthinatural123/testing:latest" 
            }
        }
        
        
        
        
       
        
    }
}
