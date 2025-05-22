pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-app'
        REGISTRY_URL = 'us.icr.io/ibmproject-sdr'
        CLUSTER_NAME = '<CLUSTER_NAME>'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/<username>/ecommerce-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $REGISTRY_URL/$DOCKER_IMAGE .'
                }
            }
        }

        stage('Push Docker Image to IBM Cloud Container Registry') {
            steps {
                script {
                    sh 'docker push $REGISTRY_URL/$DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh '''
                    ibmcloud login --apikey <API_KEY> -r us-south -g Default
                    ibmcloud ks cluster config --cluster $CLUSTER_NAME
                    kubectl apply -f k8s/deployment.yaml
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully.'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}
