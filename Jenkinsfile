pipeline {
    agent { label 'Docker' }
    stages {
        stage('build') {
            environment {
                VERSION = sh(script: 'git rev-parse --short HEAD', returnStdout: true)
            }
            steps {
                git credentialsId: 'github_token', url: 'https://github.com/ahopgood/build-your-own-radar.git', branch: '${BRANCH_NAME}'
                sh 'docker --version'
                sh 'echo "TAG Version ${VERSION}"'
                sh 'docker build . -t reclusive/build-your-own-radar:${VERSION}'
            }
        }
    }
}