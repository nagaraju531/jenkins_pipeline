pipeline {
    agent any
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
              
                sh 'sudo docker build -t samplewebapp:latest .' 
                sh 'sudo docker tag samplewebapp nraju531/samplewebapp:latest'
                //sh 'docker tag samplewebapp nikhilnidhi/samplewebapp:$BUILD_NUMBER'
               
          }
        }
        
        stage('Publish image to Docker Hub') {
          
            steps {
        withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
          sh  'sudo docker push raju531/samplewebapp:latest'
        //  sh  'docker push nikhilnidhi/samplewebapp:$BUILD_NUMBER' 
        }
                  
          }
        }
     
      stage('Run Docker container on Jenkins Agent') {
             
            steps 
   {
                sh "sudo docker run -d -p 8003:8060 push/samplewebapp"
 
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
