pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('Dockerhub') // Your Jenkins credential ID for Docker Hub
        IMAGE_NAME = 'krishna8123/web-buddy'
        TAG = 'latest'
    }

    stages {
        stage('📦 Clone Repository') {
            steps {
                git 'https://github.com/Krishna8123/Web-buddy.git'
            }
        }

        stage('🏗️ Build Docker Image') {
            steps {
                bat '''
                    docker build -t %IMAGE_NAME%:%TAG% .
                '''
            }
        }

        stage('🔐 Login & Push to Docker Hub') {
            steps {
                bat '''
                    echo %DOCKER_HUB_CREDENTIALS_PSW% | docker login -u %DOCKER_HUB_CREDENTIALS_USR% --password-stdin
                    docker push %IMAGE_NAME%:%TAG%
                '''
            }
        }

        stage('🚿 Logout & Cleanup') {
            steps {
                bat '''
                    docker logout
                    docker rmi %IMAGE_NAME%:%TAG%
                '''
            }
        }
    }

    post {
        failure {
            echo '❌ Something went wrong...'
        }
    }
}
