#!groovy
pipeline {
    agent any
    node('ecs'){
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
                build job: 'e2e_pip2', parameters: [[$class: 'hw.sh', name: 'node', label: 'ecs']]
            }
        }
    }
}
