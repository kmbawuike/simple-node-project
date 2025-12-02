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
            incrementNodeApplication("kelz107/nana-projects")
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
          buildImage(env.IMAGE_NAME)
        }
      }
    }

    stage('deploy'){
      steps {
        script{      
          def ec2Instance = "ec2-user@99.79.74.154"
          def shellCmd = "bash ./server-cmd.sh ${env.IMAGE_NAME}"
            sshagent(['aws-ec2-ssh']) {
                sh "scp -o StrictHostKeyChecking=no server-cmd.sh ${ec2Instance}:/home/ec2-user"
                sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
            }
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
