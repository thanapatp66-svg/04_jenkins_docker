pipeline {
    agent any

    triggers {
        // Poll SCM as fallback if webhook fails
        pollSCM('H/2 * * * *')
    }

    environment {
        // Build Information
        BUILD_TAG = "${env.BUILD_NUMBER}"
        GIT_COMMIT_SHORT = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
        COMPOSE_FILE = 'docker-compose.yml' // Docker Compose file path
    }

    parameters {
        booleanParam(
            name: 'CLEAN_VOLUMES',
            defaultValue: true,
            description: 'Remove volumes (clears database)'
        )
        string(
            name: 'API_HOST',
            defaultValue: 'http://192.168.56.1:3001',
            description: 'API host URL for frontend to connect to.'
        )
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    echo "Checking out code..."
                    checkout scm
                    echo "Deploying to production environment"
                    echo "Build: ${BUILD_TAG}, Commit: ${GIT_COMMIT_SHORT}"
                }
            }
        }

        stage('Validate') {
            steps {
                script {
                    echo "Validating Docker Compose configuration..."
                    sh "docker compose -f ${COMPOSE_FILE} config"
                }
            }
        }

        stage('Check Dockerfiles') {
            steps {
                script {
                    if (!fileExists('01_api/Dockerfile')) error "❌ Missing Dockerfile for API"
                    if (!fileExists('02_frontend/Dockerfile')) error "❌ Missing Dockerfile for Frontend"
                    echo "✅ Dockerfiles found."
                }
            }
        }

        stage('Prepare Environment') {
            steps {
                script {
                    echo "Preparing environment configuration..."
                    withCredentials([
                        string(credentialsId: 'MYSQL_ROOT_PASSWORD', variable: 'MYSQL_ROOT_PASS'),
                        string(credentialsId: 'MYSQL_PASSWORD', variable: 'MYSQL_PASS')
                    ]) {
                        // Create .env file
                        sh """
                            cat > .env <<EOF
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASS}
MYSQL_DATABASE=attractions_db
MYSQL_USER=attractions_user
MYSQL_PASSWORD=${MYSQL_PASS}
MYSQL_PORT=3306
PHPMYADMIN_PORT=8888
API_PORT=3001
DB_PORT=3306
FRONTEND_PORT=3000
NODE_ENV=production
API_HOST=${params.API_HOST}
EOF
                        """
                    }
                    echo ".env file created successfully"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Deploying to production using Docker Compose..."
                    def downCommand = "docker compose -f ${COMPOSE_FILE} down"
                    if (params.CLEAN_VOLUMES) {
                        echo "⚠️ Removing volumes (database will be cleared)"
                        downCommand += " -v"
                    }
                    sh downCommand

                    // Build and start services
                    sh """
                        docker compose -f ${COMPOSE_FILE} build --no-cache
                        docker compose -f ${COMPOSE_FILE} up -d
                    """
                    echo "Deployment completed"
                }
            }
        }

        stage('Health Check') {
            steps {
                script {
                    echo "Waiting for services to start..."
                    sh 'sleep 15'

                    echo "Performing health check..."
                    sh """
                        # Wait for API to be ready (max 60 seconds)
                        timeout 60 bash -c 'until curl -f http://localhost:3001/health; do sleep 2; done' || exit 1

                        # Check attractions endpoint
                        curl -f http://localhost:3001/attractions || exit 1

                        echo "Health check passed!"
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    echo "Verifying all services..."
                    sh """
                        echo "=== Container Status ==="
                        docker compose -f ${COMPOSE_FILE} ps

                        echo ""
                        echo "=== Service Logs (last 20 lines) ==="
                        docker compose -f ${COMPOSE_FILE} logs --tail=20

                        echo ""
                        echo "=== Deployed Services ==="
                        echo "Frontend: http://localhost:3000"
                        echo "API: http://localhost:3001"
                        echo "phpMyAdmin: http://localhost:8888"
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment completed successfully!"
            echo "Build: ${BUILD_TAG}"
            echo "Commit: ${GIT_COMMIT_SHORT}"
            echo ""
            echo "Access your application:"
            echo "  - Frontend: http://localhost:3000"
            echo "  - API: http://localhost:3001"
            echo "  - phpMyAdmin: http://localhost:8888"
        }

        failure {
            echo "❌ Deployment failed!"
            script {
                echo "Printing container logs for debugging..."
                sh "docker compose -f ${COMPOSE_FILE} logs --tail=50 || true"
            }
        }

        always {
            echo "Cleaning up old Docker resources..."
            sh """
                docker image prune -f
                docker container prune -f
            """
        }
    }
}
