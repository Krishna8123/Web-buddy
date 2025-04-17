pipeline {
    agent any

    environment {
        IMAGE_NAME = 'your-dockerhub-username/web-buddy'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
    }

    stages {
        stage('📥 Clone Repository') {
            steps {
                git 'https://github.com/your-github-username/web-buddy.git'
            }
        }

        stage('🐳 Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('🔐 Login & Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_CREDENTIALS_ID}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $IMAGE_NAME
                    '''
                }
            }
        }

        stage('🚿 Logout & Cleanup') {
            steps {
                sh 'docker logout'
            }
        }
    }

    post {
        success {
            echo '🎉 Web Buddy Docker Image Successfully Built and Pushed!'
        }
        failure {
            echo '❌ Something went wrong...'
        }
    }
}
