pipeline {
    agent { label 'Docker' }
    environment {
                HASH = sh(script: 'git rev-parse --short HEAD | tr -d "\n"', returnStdout: true)
                DATE = sh(script: 'date "+%Y%m%d-%H%M"', returnStdout: true)
                VERSION = "${HASH}-${DATE}"
    }
    stages {
        stage('build') {
            steps {
                git credentialsId: 'github_token', url: 'https://github.com/ahopgood/build-your-own-radar.git', branch: '${BRANCH_NAME}'
                sh 'docker --version'
                sh 'echo "TAG Version ${DOCKER_REGISTRY} ${VERSION}"'
                sh 'docker build . -t ${DOCKER_REGISTRY}/reclusive/build-your-own-radar:${VERSION}'
            }
        }
        stage('push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker --version'
                    sh 'echo "Pushing ${DOCKER_REGISTRY}/reclusive/build-your-own-radar:${VERSION}"'
                    sh 'echo ${PASSWORD} | docker login --username ${USERNAME} --password-stdin  https://${DOCKER_REGISTRY}'
                    sh 'docker push ${DOCKER_REGISTRY}/reclusive/build-your-own-radar:${VERSION}'
                    sh 'docker logout https://${DOCKER_REGISTRY}'
                }
            }
        }
    }
}