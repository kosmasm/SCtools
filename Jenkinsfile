pipeline {
  agent any
  stages {
    stage('aaa') {
      steps {
        echo 'helo'
      }
    }

    stage('bbb') {
      steps {
        input(message: 'give me ok', id: 'ok', ok: 'ok')
      }
    }

    stage('ccc') {
      steps {
        sh 'ps -ef'
      }
    }

  }
}