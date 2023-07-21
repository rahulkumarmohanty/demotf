pipeline {
    agent any
    environment {
        INFRACOST_API_KEY = "ico-v188MHnFUuLsKsSNOYLXfIhnL7ANIkaw"
        APP_ID = "06e302f7-1f8b-4c2c-921a-daa2c3c2b630"
        SECRET_KEY = "uYy8Q~CzeSFxBjV5dezAL9hgwaCpyBK.G_mPmcp_"
        TENANT_ID = "1e0b7619-b37d-4b53-a46b-35a1180b4632"
        SUBSCRIPTION_ID = "2ed1a4b1-8d67-48fb-8ef6-0d8fa4ab6a5d"
    }

    parameters {
        choice choices: ['Terraform Init & Plan & Apply'], description: 'Choose any one of the Terraform actions to perform..', name: 'terraformaction'
        choice choices: ['Windows VM'], description: 'Choose any one of the Resource to deploy in the Azure Environment..', name: 'resource'
    }

    stages {
        stage('azure cli logging') {
            steps{
                sh 'az login --service-principal --username ${env.APP_ID} --password ${env.SECRET_KEY} --tenant ${env.TENANT_ID}'
                sh 'az account set --subscription "{env.SUBSCRIPTION_ID}'
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