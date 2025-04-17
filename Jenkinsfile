pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'krishna8123/web-buddy'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('📥 Clone Repository') {
            steps {
                git url: 'https://github.com/Krishna8123/Web-buddy.git', branch: 'main'
            }
        }

        stage('🏗️ Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('🔐 Login & Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('🧹 Cleanup') {
            steps {
                sh 'docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG} || exit 0'
            }
        }
    }

    post {
        failure {
            echo "❌ Something went wrong..."
        }
        success {
            echo "✅ Pipeline completed successfully!"
        }
    }
}
