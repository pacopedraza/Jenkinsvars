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
        stage('Test'){
            steps {
                sh 'python3 input_to_secondjob.py'
            }
        }
    }
}
