pipeline {
    agent any

    environment {
        // GitHub Container Registry details
        REGISTRY = 'ghcr.io'
        GITHUB_USER = 'musyaffa-iman'
        IMAGE_NAME = 'dummy-gnb'
        FULL_IMAGE_NAME = "${REGISTRY}/${GITHUB_USER}/${IMAGE_NAME}"
        
        // Jenkins Credentials ID for GHCR authentication
        // Type: Username with password (GitHub username + GitHub PAT) or Secret text
        GHCR_CREDENTIALS_ID = 'ghcr-credentials'
    }

    options {
        timeout(time: 15, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '10'))
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout Source') {
            steps {
                echo "Fetching source code from repository..."
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${FULL_IMAGE_NAME}:${env.BUILD_NUMBER} and latest..."
                    sh """
                        docker build -t ${FULL_IMAGE_NAME}:${env.BUILD_NUMBER} \
                                     -t ${FULL_IMAGE_NAME}:latest .
                    """
                }
            }
        }

        stage('Verify Image') {
            steps {
                script {
                    echo "Inspecting built image..."
                    sh "docker image inspect ${FULL_IMAGE_NAME}:latest --format 'Image Size: {{.Size}} bytes'"
                }
            }
        }

        stage('Push to GHCR') {
            steps {
                script {
                    echo "Authenticating and pushing image to GitHub Container Registry (${REGISTRY})..."
                    withCredentials([usernamePassword(
                        credentialsId: "${GHCR_CREDENTIALS_ID}",
                        usernameVariable: 'REGISTRY_USER',
                        passwordVariable: 'REGISTRY_TOKEN'
                    )]) {
                        sh '''
                            echo "$REGISTRY_TOKEN" | docker login "$REGISTRY" -u "$REGISTRY_USER" --password-stdin
                            docker push "${FULL_IMAGE_NAME}:${BUILD_NUMBER}"
                            docker push "${FULL_IMAGE_NAME}:latest"
                            docker logout "$REGISTRY"
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline run completed."
        }
        success {
            echo "Successfully built and pushed ${FULL_IMAGE_NAME}:latest to GHCR."
        }
        failure {
            echo "Pipeline failed. Please inspect console logs for details."
        }
    }
}
