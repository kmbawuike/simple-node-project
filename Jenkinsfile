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
          deployDockerImage("aws-ec2-ssh", "aws-ec2@15.223.209.219", "3000:3000", env.IMAGE_NAME)
        }
      }
    }

    stage('Commit and Push Version Bump') {
      steps {
         commitAndBump('git-ssh', 'git@github.com:kmbawuike/simple-node-project.git', 'main')
      }
    }
  }
}
