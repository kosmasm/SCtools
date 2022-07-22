pipeline {
  agent any
  stages {
    stage('stage1') {
      steps {
        echo 'test1'
        sleep 1
        sh 'echo test2'
      }
    }

    stage('stage2') {
      steps {
        echo 'Step 2'
      }
    }

  }
}