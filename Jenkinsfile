pipeline {
    agent any
    environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerHub')
	}
    tools {
        maven 'mvn'
    }
    stages {
        stage('check out') {
            steps {
                 git branch: 'master',
                 credentialsId: 'Github',
                 url: 'https://github.com/nagaraju531/Maven.git'
            }
        }
        stage('compile the code'){
            steps {
                sh 'mvn clean compile test package'
            }
        }
        
        stage('Docker Build and Tag') {
           steps {
              
                sh 'docker build -t samplewebapp:latest .' 
                sh 'docker tag samplewebapp nraju531/samplewebapp:latest'
                //sh 'docker tag samplewebapp nikhilnidhi/samplewebapp:$BUILD_NUMBER'
               
          }
        }
        
        stage('Login') {
            steps {
             sh 'echo $DOCKERHUB_CREDENTIALS_PSW| docker login -u $DOCKERHUB_CREDENTIALS_USR --password'
	        
            }
        }
        
        stage('Publish image to Docker Hub') {     
            steps {
          sh  'docker push raju531/samplewebapp:latest'
        //  sh  'docker push nikhilnidhi/samplewebapp:$BUILD_NUMBER'
                  
          }
        }
     
      stage('Run Docker container on Jenkins Agent') {
             
            steps 
            {
                sh "docker run -d -p 8003:8060 push/samplewebapp"
 
            }
        }
         stage('Deploy the code'){
            steps {
                sshagent(['vagrant']) {
                   sh "cp /var/lib/jenkins/workspace/Declarative-Pipeline/target/*.war /opt/tomcat/tomcat9/webapps"
                                      }
                  }
                                }
        
        stage('Deploy To Nexus'){
            steps {
                   nexusArtifactUploader artifacts: [[artifactId: 'GUI-Application', classifier: '', file: 'target/GUI-Application-001v.war', type: 'war']], credentialsId: 'nexus-id', groupId: 'GUI.com', nexusUrl: '192.168.33.10:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'test', version: '001v'
            }
        }
        
    }
}
