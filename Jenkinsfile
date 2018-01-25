#!groovy
pipeline {
    agent any
    environment {
        CC = 'clang'
    }
    stages {
        stage('Test Automation Code'){
            environment {
                DEBUG_FLAGS = '-g'
            }
            steps {
                sh 'printenv'
            }
        }
        stage('Send Artifact to Second Job'){
            steps {
                sh 'pwd'
            }
        }
    }
}
