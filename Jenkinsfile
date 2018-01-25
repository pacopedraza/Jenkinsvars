#!groovy
pipeline {
    agent any
    environment {
        CC = 'clang'
    }
    stages {
        stage('Build and archive artifacts'){
            steps {
                sh 'make'
                archiveArtifacts artifacts: '/var/jenkins_home/workspace/e2e_pip/hw.sh', fingerprint: true
            }
        }
        stage('Test'){
            steps {
                sh 'python input_to_secondjob.py'
            }
        }
    }
}
