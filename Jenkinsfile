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
        stage('Check Ansible Version') {
            steps {
                sh 'ansible-playbook --version'
            }
        }
    stages {
        stage('Deploy Role') {
            steps {
                checkout scm
                ansiblePlaybook(
                    playbook: 'home/ubuntu/ansible/playbook2.yml',
                    inventory: 'home/ubuntu/ansible/hosts.txt',
                    extras: "-e TAG=${env.TAG}",
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
}