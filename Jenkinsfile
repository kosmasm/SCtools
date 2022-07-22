pipeline {
  agent any
  stages {
    stage('Show') {
      steps {
        echo 'Startnig Pipeline'
      }
    }

    stage('Ask') {
      steps {
        input(message: 'Give ', id: 'od', ok: 'ok')
      }
    }

    stage('Print') {
      steps {
        echo 'Ansered ok'
      }
    }

    stage('Finish') {
      steps {
        sh '''set
echo Finished'''
      }
    }

  }
}