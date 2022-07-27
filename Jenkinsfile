pipeline {
  agent any
  stages {
    stage('WaitCampaigns') {
      steps {
        ebWaitOnEnvironmentStatus(applicationName: '/tmp/getcampaigns', environmentName: 'campaings', status: '0')
      }
    }

    stage('AskInput') {
      steps {
        ebWaitOnEnvironmentStatus(applicationName: '/tmp/waitcampaign.sh', environmentName: 'campaigns', status: '0')
      }
    }

    stage('Pause') {
      steps {
        sh 'sh /tmp/pause.sh'
      }
    }

  }
}