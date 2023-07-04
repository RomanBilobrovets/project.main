#!/usr/bin/env groovy

pipeline {
    agent any

    environment {
        TAG = "first"
    }

    parameters {
        choice (name: 'SERVER', choices: ['ec2_dev', 'ec2_test', 'ec2_stage'], description: 'Select env for deploy')
    }

    stages {
        stage('Deploy Role') {
            steps {
                ansiblePlaybook(
                    playbook: 'home/ubuntu/ansible/playbook2.yml',
                    inventory: 'home/ubuntu/ansible/hosts.txt',
                    extras: "-e TAG=${TAG}",
                    tags: 'deploy_apache',
                    colorized: true
                )
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}