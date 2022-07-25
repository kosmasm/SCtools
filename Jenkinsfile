pipeline {
  agent any
  stages {
    stage('print') {
      steps {
        echo 'start'
      }
    }

    stage('input') {
      steps {
        input(message: 'enter ok', id: 'ok', ok: 'ok')
      }
    }

    stage('shell') {
      steps {
        sh '''ps -ef
'''
      }
    }

  }
}