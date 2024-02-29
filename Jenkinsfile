pipeline {
    agent any

    stages {
        stage('pull code') {
            steps {
                git branch: 'main', credentialsId: 'github-credentials', url: 'git@github.com:xubeijun/certbot-toy.git'
            }
        }
        stage('build project') {
            steps {
                sh '''echo "开始构建"
echo "构建完成"'''
            }
        }
        stage('deploy project') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: '192.168.0.100', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'echo "Jenkins pipelien success"', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: 'pipeline-test', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'scripts/**')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}
