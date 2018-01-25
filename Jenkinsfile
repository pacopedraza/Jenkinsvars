#!groovy
pipeline {
    agent any
    stages {
        stage('Build and archive artifacts'){
            steps {
                sh 'echo Is going to try to save artifacts'
                archiveArtifacts artifacts: 'hw.sh', fingerprint: true
            }
        }
        stage('Downstream and Test job'){
            steps {
                build job: 'e2e_pip2', parameters: [[$class: 'LabelParameter', name: 'node', label: 'ecs']]
            }
        }
    }
}
