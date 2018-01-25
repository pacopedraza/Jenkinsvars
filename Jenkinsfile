#!groovy
pipeline {
    agent any
    environment {
        CC = 'clang'
    }
    stages {
        stage('Build and archive artifacts'){
            steps {
                sh 'echo Is going to try to save artifacts'
                archiveArtifacts artifacts: 'hw.sh', fingerprint: true
            }
        }
        stage('Downstream and Test job'){
            steps {
                build job: 'End to End Testing/e2e_1'
            }
        }
    }
}
