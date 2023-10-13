pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git branch: 'main', credentialsId: '89b0cb60-552b-4215-92a4-dae805cfc5ab', url: 'https://github.com/SatishChitimoju007/terraformawscicd.git'
                        }
                    }
                }
            }

    stage('Plan') {
        steps {
            bat '''
                cd terraform
                terraform init
                terraform plan -out tfplan
                terraform show -no-color tfplan > tfplan.txt
            '''
        }
    }

        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'terraformawscicd/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                sh "pwd; terraform apply -input=false tfplan"
            }
        }
    }

  }
