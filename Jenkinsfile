pipeline {
    agent any

    tools {
       terraform 'terraform'
    }

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'prod'], description: 'Select the environment')
        choice(name: 'OPERATION', choices: ['init', 'plan', 'apply', 'destroy'], description: 'Select the Terraform operation')
    }
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TERRAFORM_DIR = "${params.ENVIRONMENT}"
    }
    stages {
         stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Initialize') {
            steps {
                script {
                    echo "Selected environment: ${params.ENVIRONMENT}"
                    echo "Selected operation: ${params.OPERATION}"
                    echo "Using Terraform directory: ${env.TERRAFORM_DIR}"
                }
            }
        }
        stage('Terraform Operation') {
            steps {
                script {
                    dir(env.TERRAFORM_DIR) {
                        switch (params.OPERATION) {
                            case 'init':
                                sh 'terraform init'
                                break
                            case 'plan':
                                sh 'terraform init'
                                sh 'terraform plan'
                                break
                            case 'apply':
                                sh 'terraform init'
                                sh 'terraform plan'
                                sh '''
                                terraform apply -auto-approve || echo "Plan file not found, ensure 'plan' is executed before 'apply'."
                                '''
                                break
                            case 'destroy':
                                sh 'terraform init'
                                sh 'terraform destroy -auto-approve'
                                break
                            default:
                                error "Unsupported Terraform operation: ${params.OPERATION}"
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}
