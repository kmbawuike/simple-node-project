pipeline {
  agent any
  stages {

    stage('increment') {
      steps {
        script {
          echo 'Incrementing version'
          dir('app'){
            def version
            def msg = sh(script: "git log -1 --pretty=%B", returnStdout: true).trim() // print out commit headline
            if (msg.contains('BREAKING CHANGE')) {
               version = sh(script: 'npm version major', returnStdout: true).trim().replace('v', '')
            } else if (msg.startsWith('feat:')) {
                version = sh(script: 'npm version minor', returnStdout: true).trim().replace('v', '')
            } else {
                version = sh(script: 'npm version patch', returnStdout: true).trim().replace('v', '')
            }
            env.IMAGE_NAME = version
          }
       
        }
      }
    }

    stage('test') {
      steps {
        script {
          dir('app'){
            echo 'Testing... the application'
            sh 'npm install'
            sh 'npm test'
          }
        }
      }
    }
    stage('build') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: 'jenkins-docker-hub', usernameVariable: 'USER', passwordVariable: "PASS")]){
          echo 'Building Docker Image... the application'
          sh "docker build -t kelz107/nana-projects:${env.IMAGE_NAME} ."
          sh "echo $PASS | docker login -u $USER --password-stdin" 
          sh "docker push kelz107/nana-projects:${env.IMAGE_NAME}"
          }
        }
      }
    }

    stage('deploy'){
      steps{
        script{
          echo 'Deploying'
        }
      }
    }
  }
}
