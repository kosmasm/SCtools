pipeline {
  agent any
  stages {
    stage('Print') {
      steps {
        echo 'Starting'
      }
    }

    stage('Input') {
      steps {
        input(message: 'Approve', id: 'inputid', ok: 'OK', submitter: 'Kosmas Mackrogamvrakis', submitterParameter: 'Approve')
      }
    }

    stage('Print2') {
      steps {
        sh '''set
'''
      }
    }

  }
}