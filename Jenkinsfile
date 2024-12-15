pipeline {
    agent any

    tools {
       terraform 'terraform'
    }

    parameters {
        choice(name: 'Environment', choices: ['dev', 'test', 'uat', 'prod'], description: 'Select Environment')
        choice(name: 'TERRAFORM_OPERATION', choices: ['plan', 'apply', 'destroy'], description: 'Select Terraform Operation')
    }

    environment {
        // TF_VAR_environment = params.TF_VAR_environment
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TERRAFORM_DIR = "${params.Environment}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    dir(env.TERRAFORM_DIR){
                        sh 'terraform init'
                }
            }
        }
        }

        stage('Terraform Operation') {
            steps {
                script {
                    // Run Terraform based on the selected operation
                    dir(env.TERRAFORM_DIR){
                        switch(params.TERRAFORM_OPERATION) {
                            case 'plan':
                                sh "terraform plan -out=tfplan"
                                break
                            case 'apply':
                                sh "terraform plan -out=tfplan"
                                sh 'terraform apply -auto-approve tfplan'
                                break
                            case 'destroy':
                                sh "terraform destroy -auto-approve"
                                break
                            default:
                                error "Invalid Terraform operation selected"
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up artifacts, e.g., the Terraform plan file
            deleteDir()
        }
    }
}