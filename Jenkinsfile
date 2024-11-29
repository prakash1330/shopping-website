pipeline {
    agent any
    stages {
        stage('Git Clone') {
            steps {
                // Cloning from GitHub
                // sh '''
                //     if [ -d "shopping-website" ]; then
                //         rm -r shopping-website
                //     fi
                // '''
                // sh 'git clone https://github.com/prakash1330/shopping-website.git'
                checkout scm
            }
        }

        stage('Set Branch Name') {
            steps {
                script {
                    // env.BRANCH_NAME = sh(script: "git -C shopping-website rev-parse --abbrev-ref HEAD", returnStdout: true).trim()
                    // sh "env.BRANCH_NAME=${GIT_BRANCH}"
                    // echo "Branch Name: ${env.BRANCH_NAME}"
                    env.BRANCH_NAME = env.GIT_BRANCH
                    echo "Branch Name: ${env.BRANCH_NAME}"
                }
                
            }
        }

        // stage('Set Image Name and Tag') {
        //     steps {
        //         script {
        //             // Reading the image name and tag from files
        //             IMAGE_NAME = readFile('shopping-website/info.txt').trim()
        //             TAG = readFile('shopping-website/tag.txt').trim()
        //         }
        //     }
        // }

        stage('Build') {
            steps {
                // Building Docker image
                dir('shopping-website') {
                    // sh "docker build -t ${IMAGE_NAME}:${TAG} ."
                    sh 'ls -al'
                    sh './build.sh'
                }
            }
        }

        stage('Deploy') {
            steps {
                // Stop the running container and spin up a new one
                dir('shopping-website') {
                    withEnv(["IMAGE_NAME=${IMAGE_NAME}", "TAG=${TAG}"]) {
                        sh 'docker-compose down'
                        sh 'docker-compose up -d'
                        // sh './deploy.sh'
                    }
                }
            }
        }

        stage('Push Image to Docker Hub if dev branch') {
            when {
                // lets see
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
