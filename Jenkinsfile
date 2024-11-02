pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')        // AWS Access Key from Jenkins
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')        // AWS Secret Key from Jenkins
        GITHUB_PAT            = credentials('github-pat')            // GitHub PAT from Jenkins
        AWS_DEFAULT_REGION    = 'us-east-1'                          // AWS region
    }

    stages {
        stage('Clean Workspace') {
            steps {
                echo 'Cleaning workspace...'
                deleteDir()
            }
        }

        stage('Setup Python Virtual Environment') {
            steps {
                sh '''
                python3 -m venv venv
                . venv/bin/activate
                pip install --upgrade pip
                pip install boto3
                '''
            }
        }

        stage('Checkout Code') {
            steps {
                dir('terraform') {
                    git(
                        url: 'https://github.com/AnandJoy7/terra_auto_testing.git',
                        branch: 'main',
                        credentialsId: 'github-credentials'
                    )
                }
            }
        }

        stage('Run Terraform Script') {
            steps {
                dir('terraform') {
                    script {
                        def result = sh(script: '''
                        . ../venv/bin/activate
                        python3 terra_auto8.py > terraform_output.log 2>&1
                        deactivate
                        ''', returnStatus: true)
                        
                        if (result != 0) {
                            error "Terraform script failed. Check terraform_output.log for details."
                        } else {
                            echo "Terraform script ran successfully."
                        }
                    }
                }
            }
        }



    post {
        always {
            echo 'Archiving Terraform output log...'
            dir('terraform') {
                archiveArtifacts artifacts: 'terraform_output.log', allowEmptyArchive: true
            }
        }
        success {
            echo 'Terraform automation completed successfully and changes pushed to new repository.'
        }
        failure {
            echo 'Terraform automation failed. Please check the logs.'
        }
    }
}
