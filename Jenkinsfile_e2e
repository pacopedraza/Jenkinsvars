#!groovy
pipeline {
    agent { node {label 'ecs' } }
    stages {
        stage('Build and archive artifacts'){
            steps {
                archiveArtifacts artifacts: 'hw.sh', fingerprint: true
            }
        }
        stage('Downstream and Test job'){
            steps {
                build job: 'e2e_pip2'
            }
        }
    }
}
