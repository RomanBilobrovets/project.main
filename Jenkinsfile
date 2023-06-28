#!/usr/bin/env groovy

pipeline {


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