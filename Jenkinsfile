pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                // cloning from github
                sh 'rm -r shopping-website'
                sh 'git clone https://github.com/prakash1330/shopping-website.git'
            }
        }

        stage('Set Image Variables') {
            steps {
                script {
                    // Reading the image name and tag from files
                    IMAGE_NAME = readFile('shopping-website/info.txt').trim()
                    TAG = readFile('shopping-website/tag.txt').trim()
                        }
                  }
            }

        stage('Build') {
            steps {
                // Building docker image
                dir('shopping-website') {
                sh "docker build -t ${IMAGE_NAME}:${TAG} ."
            }
        }
        }

        stage('Deploy') {
            steps {
                // Stop the running container and spin up new one
                dir('shopping-website') {
                    withEnv(["IMAGE_NAME=${IMAGE_NAME}", "TAG=${TAG}"]) {
                sh 'docker-compose down'
                sh 'docker-compose up -d'
            }
        }
            }
        }

        stage('Pushing image to docker hub'){
            when{
                branch 'main'
            }
            steps {
                dir('shopping-website') {
                sh "docker tag ${IMAGE_NAME}:${TAG} prakash112/dev:${TAG}"
                sh "docker push prakash112/dev:${TAG}"
        }
             }
        }

        stage(' pushing image to docker hub'){
            when{
                branch 'dev'
            }
            steps{
                dir('shopping-website') {
                sh "docker tag ${IMAGE_NAME}:${TAG} prakash112/prod:${TAG}"
                sh "docker push prakash112/prod:${TAG}"
            }
            }
        }

    }

}






























// pipeline {
//     agent any

//     stages {
//         stage('Git Clone') {
//             steps {
//                 // cloning from github
//                 sh 'git clone https://github.com/prakash1330/shopping-website.git'
//             }
//         }

//         stage('Set Image Variables') {
//             steps {
//                 script {
//                     // Reading the image name and tag from files
//                     IMAGE_NAME = readFile('shopping-website/info.txt').trim()
//                     TAG = readFile('shopping-website/tag.txt').trim()
//                         }
//                   }
//             }

//         stage('Build') {
//             steps {
//                 // Building docker image
//                 sh "docker build -t ${IMAGE_NAME}:${TAG} ."
//             }
//         }

//         stage('Deploy') {
//             steps {
//                 // Stop the running container and spin up new one
//                 sh 'docker-compose down'
//                 sh 'docker-compose up -d'
//             }
//         }

//         stage('Pushing image to docker hub'){
//             when{
//                 branch 'main'
//             }
//             steps {
//                 sh "docker tag ${IMAGE_NAME}:${TAG} prakash112/dev:${TAG}"
//                 sh "docker push prakash112/dev:${TAG}"
//             }
//         }

//         stage(' pushing image to docker hub'){
//             when{
//                 branch 'Dev'
//             }
//             steps{
//                 sh "docker tag ${IMAGE_NAME}:${TAG} prakash112/prod:${TAG}"
//                 sh "docker push prakash112/prod:${TAG}"
//             }
//         }

//     }

// }

