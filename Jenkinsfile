pipeline {
    agent { label 'Docker' }
    stages {
        stage('build') {
            steps {
                git credentialsId: 'github_token', url: 'https://github.com/ahopgood/build-your-own-radar.git', branch: '${BRANCH_NAME}'
                sh 'docker --version'
                def version = sh '$(git rev-parse --short HEAD)'
                def customImage = docker.build("reclusive/build-your-own-radar:${env.version}")
            }
        }
    }
}