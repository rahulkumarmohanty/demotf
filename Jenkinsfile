pipeline {
    agent any
    environment {
        INFRACOST_API_KEY = "ico-v188MHnFUuLsKsSNOYLXfIhnL7ANIkaw"
        ARM_CLIENT_ID = "06e302f7-1f8b-4c2c-921a-daa2c3c2b630"
        ARM_TENANT_ID = "1e0b7619-b37d-4b53-a46b-35a1180b4632"
    }

    parameters {
        choice choices: ['Terraform Init & Plan & Apply'], description: 'Choose any one of the Terraform actions to perform..', name: 'terraformaction'
        choice choices: ['Windows VM'], description: 'Choose any one of the Resource to deploy in the Azure Environment..', name: 'resource'
        choice choices: ['2ed1a4b1-8d67-48fb-8ef6-0d8fa4ab6a5d'], description: 'Choose any of the subscription id..', name: 'ARM_SUBSCRIPTION_ID'
        string(name: 'ARM_CLIENT_SECRET', description: 'Enter the client secret')
    }

    stages {
        stage('azure cli logging') {
            steps{
                sh 'az login --service-principal --username ${ARM_CLIENT_ID} --password ${params.ARM_CLIENT_SECRET} --tenant ${ARM_TENANT_ID}'
                sh 'az account set --subscription ${params.ARM_SUBSCRIPTION_ID}'
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
            post {
                always{
                    archiveArtifacts artifacts:'*', onlyIfSuccessful: true
                }
            }
        }
        
        stage('Terraform Plan View') {
            steps {
                sh 'terraform show myplan.tfplan > readable_plan.txt'
                sh 'cat readable_plan.txt'
            }
        }
        
        stage('Tfsec Check for potential security issues') {
            steps {
                script {
                  try {
                    sh 'tfsec .'
                } catch (Exception e) {
                    // handle the error or ignore it
                        echo "Error occurred: ${e.message}"
                }
             }
          }
        }
        
        stage('Checkov') {
            steps {
                script {
                  try {
                    sh 'checkov -d .'
                } catch (err) {
                  echo 'Checkov check failed, continuing pipeline'
                  echo err.getMessage()
                }
              }
           }
        }


        stage('Infracost Breakdown') {
            steps {
                sh 'infracost breakdown --path myplan.tfplan'
            }
        }
        
        stage('Drift Detection') {
            steps {
                script {
                  try {
                    sh 'driftctl scan --from tfstate+s3://1ch-aws-terraform/terraform.tfstate'
                } catch (Exception e) {
                    // handle the error
                    echo "Error occurred: ${e.message}"
                }
             }
          }
        }
    }
}
