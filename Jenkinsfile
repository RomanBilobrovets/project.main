#!/usr/bin/env groovy

pipeline {
    agent any

environment {
    TAG = "first"
}

parameters {
    choice (name: 'SERVER', choices: ['ec2_dev', 'ec2_test', 'ec2_stage'], description: '''
    Select env for deploy
    ''')
}

stages {
    stage('Deploy ec2_dev'){
        when { expression { params.SERVER == 'ec2_dev' } }
        steps{
            script{
                echo "Hello dev ${TAG}"
                sh "java --version"
                sh "pwd"
                sh "curl -f -LI http://google.com"
            }
        }
    }
    stage('Deploy ec2_test'){
        when { expression { params.SERVER == 'ec2_test' } }
        steps{
            script{
                echo "hello test"
            }
        }
    }
    stage('Deploy ec2_stage'){
        when { expression { params.SERVER == 'ec2_stage' } }
        steps{
            script{
                echo "hello stage"
            }
        }
    }
}

post {
    always {
        cleanWs()
    }
}
}