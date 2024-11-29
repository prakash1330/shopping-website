pipeline {
    agent any
    stages {
        stage('Git') {
            steps {
                checkout scm
            }
        }

        stage('Set Branch Name') {
            steps {
                script {
                    // setting up branch name env variable
                    env.BRANCH_NAME = env.GIT_BRANCH
                    echo "Branch Name: ${env.BRANCH_NAME}"
                }
            }
        }

        stage('Set Image Name and Tag') {
            steps {
                script {
                    // Reading the image name and tag from files
                    IMAGE_NAME = readFile('info.txt').trim()
                    TAG = readFile('tag.txt').trim()
                }
            }
        }

        stage('Build') {
            steps {
                // Building Docker image using build.sh script
                 sh 'chmod +x build.sh'
                 sh './build.sh'
            }
        }

        stage('Deploy') {
            steps {
                // Stoping existing container and deploying new one
                 sh 'chmod +x deploy.sh'
                 sh './deploy.sh'
            }
        }

        stage('Push Image to Docker Hub if dev branch') {
            when {
              expression { env.BRANCH_NAME == 'origin/dev' }
            }
            steps {
                dir('shopping-website') {
                    sh "docker tag ${IMAGE_NAME}:${TAG} prakash112/dev:${TAG}"
                    sh "docker push prakash112/dev:${TAG}"
                }
            }
        }

        stage('Push Image to Docker Hub if main branch') {
            when {
                expression { env.BRANCH_NAME == 'origin/main' }
            }
            steps {
                dir('shopping-website') {
                    sh "docker tag ${IMAGE_NAME}:${TAG} prakash112/prod:${TAG}"
                    sh "docker push prakash112/prod:${TAG}"
                }
            }
        }
    }
}
