pipeline {
    agent any
    environment {
        INFRACOST_API_KEY = "ico-v188MHnFUuLsKsSNOYLXfIhnL7ANIkaw"
        ARM_CLIENT_ID = "853d1487-f659-4a81-8788-cfb52f62fe0f"
        ARM_CLIENT_SECRET = "jCt8Q~jiQXxENivxnHYZOAcPpwtmxtBML4nDFadC"
        ARM_TENANT_ID = "1e0b7619-b37d-4b53-a46b-35a1180b4632"
        ARM_SUBSCRIPTION_ID = "780f8b48-d256-4702-b9fd-0d0fd40a21a8"
    }

    parameters {
        choice choices: ['Terraform Init & Plan & Apply'], description: 'Choose any one of the Terraform actions to perform..', name: 'terraformaction'
        choice choices: ['Windows VM'], description: 'Choose any one of the Resource to deploy in the Azure Environment..', name: 'resource'
    }

    stages {
        stage('azure cli logging') {
            steps{
                sh 'az login --service-principal --username ${ARM_CLIENT_ID} --password ${ARM_CLIENT_SECRET} --tenant ${ARM_TENANT_ID}'
                sh 'az account set --subscription ${ARM_SUBSCRIPTION_ID}'
            }
        }

        stage('Terraform Initialize') {
            steps {
                sh 'terraform init'
            }
       }

       stage('TFLint') {
            steps {
                sh 'tflint --ignore-module=SweetOps/storage-bucket/aws'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    def tfplan = sh(script: 'terraform plan -out=myplan.tfplan -input=false', returnStdout: true).trim()
                    writeFile file: 'tfplan', text: tfplan
                }
            }
        }
    }
}
