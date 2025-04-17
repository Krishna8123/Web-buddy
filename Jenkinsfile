pipeline {
    agent any

    stages {
        stage('📦 Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Krishna8123/Web-buddy.git'
            }
        }

        stage('🛠️ Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("krishna8123/web-buddy:${BUILD_NUMBER}")
                }
            }
        }

        stage('🔐 Login & Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                        dockerImage.push()
                    }
                }
            }
        }

        stage('🚮 Logout & Cleanup') {
            steps {
                script {
                    sh 'docker logout'
                    sh 'docker rmi krishna8123/web-buddy:${BUILD_NUMBER}'
                }
            }
        }
    }

    post {
        failure {
            echo '❌ Something went wrong...'
        }
        success {
            echo '✅ Build and push completed successfully!'
        }
    }
}
