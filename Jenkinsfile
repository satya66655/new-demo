pipeline {

    agent any

    options {
        skipDefaultCheckout(true)
    }

    environment {

        // ===== USER CONFIGURATION VARIABLES =====

        REPO_URL = "https://github.com/satya66655/new-demo.git"
        
        REPO_BRANCH = "main"

        WEB_SERVER = "34.207.210.122"

        SSH_KEY = "/var/lib/jenkins/886436941748_NV-Mar-25.pem"

        APP_PACKAGE = "webapp.tar.gz"

    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: "${REPO_BRANCH}", url: "${REPO_URL}"
            }
        }

        stage('Build') {
            steps {
                sh '''
                echo "Injecting Jenkins build number into webpage"
                sed -i "s/VERSION/${BUILD_NUMBER}/g" index.html
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                chmod +x test.sh
                ./test.sh
                '''
            }
        }

        stage('Package Application') {
            steps {
                sh '''
                echo "Packaging application artifact"
                tar -czf ${APP_PACKAGE} index.html
                '''
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                echo "Copying artifact to Web Server"

                scp -i ${SSH_KEY} -o StrictHostKeyChecking=no ${APP_PACKAGE} ec2-user@${WEB_SERVER}:/tmp/

                echo "Deploying application on Web Server"

                ssh -i ${SSH_KEY} -o StrictHostKeyChecking=no ec2-user@${WEB_SERVER} "
                sudo tar -xzf /tmp/${APP_PACKAGE} -C /var/www/html/
                "
                '''
            }
        }

    }

}
