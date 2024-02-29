pipeline {
    agent any

    parameters {
        choice(name: 'TERRAFORM_ACTION', choices: ['apply', 'destroy'], description: 'Select Terraform action to perform')
    }
    
    environment {    
        // Azure Service Principal credentials
        AZURE_CREDENTIALS_ID = credentials('lili-acr-credentials-id')
        AZURE_SUBSCRIPTION_ID = credentials('lil-sp-subscription-id')
        AZURE_TENANT_ID = credentials('lil-sp-tenant-id')
        AZURE_CLIENT_ID = credentials('lil-sp-client-id')
        AZURE_CLIENT_SECRET = credentials('lil-sp-client-secret-id')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/lily4499/acr-test.git'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Action') {
            steps {
                script {
                    if (params.TERRAFORM_ACTION == 'apply') {
                        sh 'terraform apply -auto-approve'
                    } else if (params.TERRAFORM_ACTION == 'destroy') {
                        sh 'terraform destroy -auto-approve'
                    } else {
                        error 'Invalid Terraform action specified!'
                    }
                }
            }
        }
    }
}
