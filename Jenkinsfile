pipeline {
    agent any
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'prod'], description: 'Select the environment')
        choice(name: 'OPERATION', choices: ['init', 'plan', 'apply', 'destroy'], description: 'Select the Terraform operation')
    }
    environment {
        TERRAFORM_DIR = "${params.ENVIRONMENT}/terraform"
    }
    stages {
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
                                sh 'terraform plan -out=tfplan'
                                break
                            case 'apply':
                                sh '''
                                terraform apply -auto-approve tfplan || echo "Plan file not found, ensure 'plan' is executed before 'apply'."
                                '''
                                break
                            case 'destroy':
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
