# Jenkinsfile(Declarative Pipeline)
pipeline {
    agent any
    environment {
        CC = 'clang'
    }
    stages {
        stage('Test'){
            environment {
                DEBUG_FLAGS = '-g'
            }
            steps {
                sh 'printenv'
            }
        }
    }
}
