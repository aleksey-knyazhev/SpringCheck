pipeline {
  agent any
  triggers {
      pollSCM '* * * * *'
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }

  stages {
    stage('Build') {
      steps {
        sh 'docker build -t aleksey/jpipeline:latest .'
      }
    }
    stage('Deploy') {
      steps {
        sh 'docker stop jenkinsCont || true && docker rm jenkinsCont || true'
        sh 'docker run --name jenkinsCont -d -p 8081:8081 aleksey/jpipeline:latest'
      }
    }
  }
    post {
      always {
        sh 'docker logout'
      }
    }

}
