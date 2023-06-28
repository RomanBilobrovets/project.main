#!/usr/bin/env groovy

pipeline {
    agent {
        label 'master'
    }
}

stages {
    stage('first stage'){
        steps{
            script{
                echo "hello world"
            }
        }
    }
}

post {
    always {
        cleanWs()
    }
}
