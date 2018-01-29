#!groovy
pipeline {
    agent any
    stages {
        stage('Build and archive artifacts'){
            steps {
                archiveArtifacts artifacts: 'hw.txt', fingerprint: true
            }
        }
        stage('Downstream and Test job'){
            steps {
                build job: 'e2e_pip2'
            }
        }
    }
}
