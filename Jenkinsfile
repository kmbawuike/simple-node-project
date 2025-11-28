library identifier: 'jenkins-shared-library@main', retriever: modernSCM(
    [$class: 'GitSCMSource',
    remote: 'https://github.com/kmbawuike/java-jenkins-shared-library.git',
    credentialsID: 'kelz-github'
    ]
)

pipeline {
  agent any
  stages {

    stage('increment') {
      steps {
        script {
          dir('app'){
            incrementNodeApplication()
          }
        }
      }
    }

    stage('test') {
      steps {
        script {
          dir('app'){
            testNodeApplication()
          }
        }
      }
    }

    stage('build') {
      steps {
        script {
          buildImage("kelz107/nana-projects:${env.IMAGE_NAME}")
        }
      }
    }

    stage('deploy'){
      steps {
        script{
             ssh-agent(['aws-ec2-ssh']) {
                sh "ssh -o StrictHostKeyChecking=no aws-ec2@15.223.209.219"
                sh "docker pull ${env.IMAGE_NAME}"
                sh "docker run -d -p 3000:3000 ${env.IMAGE_NAME}"
            }
          // deployDockerImage("aws-ec2-ssh", "aws-ec2@15.223.209.219", "3000:3000", env.IMAGE_NAME)
        }
      }
    }

    stage('Commit and Push Version Bump') {
      steps {
         commitAndBump('git-ssh', 'git@github.com:kmbawuike/simple-node-project.git', 'master')
      }
    }
  }
}
