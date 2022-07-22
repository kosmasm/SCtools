pipeline {
  agent any
  stages {
    stage('Print') {
      steps {
        echo 'Hello'
      }
    }

    stage('Input') {
      steps {
        input(message: 'Approve', id: 'Parameter', ok: 'Accpet')
      }
    }

    stage('Finish') {
      steps {
        sh '''set
'''
      }
    }

  }
}