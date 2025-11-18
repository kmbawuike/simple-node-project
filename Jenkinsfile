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
                version = sh(script: 'npm version minor —no-git-tag-version', returnStdout: true).trim().replace('v', '')
            } else {
                version = sh(script: 'npm version patch', returnStdout: true).trim().replace('v', '')
            }
            env.IMAGE_NAME = "${version}-${env.BUILD_NUMBER}"
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

    stage('committing incremented version to github'){
      steps {
        script {
            withCredentials([usernamePassword(credentialsId: 'kelz-github', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                # git config here for the first time run
                sh 'git config --global user.email "jenkins@example.com"'
                sh 'git config --global user.name "jenkins"'
                echo 'https://$USER:$PASS@github.com/kmbawuike/simple-node-project.git'
                sh 'git remote set-url origin https://$USER:$PASS@github.com/kmbawuike/simple-node-project.git'
                sh 'git add .'
                sh 'git commit -m "ci: version bump"'
                sh 'git push origin HEAD:jenkins-ci'
            }
        }
      }
    }
  }
}
