pipeline {
  agent any
  stages {
    stage('GetGampaigns') {
      steps {
        ebWaitOnEnvironmentHealth(applicationName: '/tmp/waitcampaigns.sh', environmentName: 'campaigns', health: '0', stabilityThreshold: 1)
      }
    }

    stage('WaitInput') {
      steps {
        input(message: 'Pause', id: 'ok', ok: 'OK')
      }
    }

    stage('Pause') {
      steps {
        sh '/tmp/pause.sh'
      }
    }

  }
}