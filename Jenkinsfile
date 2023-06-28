#!/usr/bin/env groovy

pipeline {
    agent any

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
}