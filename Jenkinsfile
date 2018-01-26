#!groovy
pipeline {
    agent any
    stages {
        stage('Build and archive artifacts'){
            steps {
                sh 'echo Is going to try to save artifacts'
                try {
                archiveArtifacts artifacts: 'hw.sh', fingerprint: true
                } catch (e) {
                    // If any exception occurs, make the build as failed.
                    currentBuild.result = 'FAILURE'
                    throw e
                  } finally {
                      // Perform workspace cleanup only if the build have passed
                      // If the build has failed, the workspace will be kept.
                      cleanWs cleanWhenFailure: false
                    }
            }
        }
        stage('Downstream and Test job'){
            steps {
                build job: 'e2e_pip2'
            }
        }
    }
}
