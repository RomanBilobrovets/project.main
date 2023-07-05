#!/usr/bin/env groovy

pipeline { // задаем тон groovy, даем понять что здесь у нас шаги пайплайна
    agent any // если у нас есть какие то jenkins агенты специально для Ansible мы можем их указать здесь, у меня только один агент, поэтому я поставлю any
   
    stages { // здесь определяем какие шаги в пайплайне
        stage('Deploy') { // наш деплой
            steps { // определяем шаги уже самого стейджа
                sh 'ansible --version' // выводим версию Ansible, команда sh просто выполнит скрипт из консоли
    stages {
        stage('Deploy Role') {
            steps {
                checkout scm
                ansiblePlaybook(
                    host_key_checking - false
                    playbook: 'home/ubuntu/ansible/playbook3.yml',
                    inventory: 'home/ubuntu/ansible/hosts.txt',
                    private_key_file = /home/ubuntu/.ssh/ansible_roles.pem
                    remote_user = ubuntu''
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