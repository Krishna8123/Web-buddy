pipeline {
    agent any

    environment {
        IMAGE_NAME = 'krishna8123/web-buddy'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // you must create this in Jenkins > Manage Credentials
    }

    stages {
        stage('📥 Clone Repository') {
            steps {
                 git branch: 'main', url: 'https://github.com/Krishna8123/Web-buddy.git'
            }
        }

        stage('📦 Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME% ."
            }
        }

        stage('🔐 Login & Push to Docker Hub') {
            steps {
                bat "docker login -u %DOCKERHUB_CREDENTIALS_USR% -p %DOCKERHUB_CREDENTIALS_PSW%"
                bat "docker push %IMAGE_NAME%"
            }
        }

        stage('🧹 Cleanup') {
            steps {
                bat "docker logout"
                bat "docker rmi %IMAGE_NAME%"
            }
        }
    }

    post {
        failure {
            echo '❌ Something went wrong...'
        }
        success {
            echo '✅ Deployment successful!'
        }
    }
}
