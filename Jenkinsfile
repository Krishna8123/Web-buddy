pipeline {
    agent any

    stages {
        stage('📥 Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Krishna8123/web-buddy.git'
            }
        }

        stage('🐳 Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t kri812/web-buddy .'
                }
            }
        }

        stage('🔐 Login & Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'Dockerhub', 
                    usernameVariable: 'DOCKER_USER', 
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push kri812/web-buddy
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
