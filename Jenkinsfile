pipeline {
  agent any
  stages {
    stage('Build') {
      parallel {
        stage('Build') {
          steps {
            echo 'Building App'
          }
        }

        stage('Test') {
          steps {
            sh 'echo Hello'
          }
        }

      }
    }

    stage('Scan') {
      steps {
        echo 'Scanning'
      }
    }

    stage('Deploy') {
      steps {
        echo 'deploying application'
      }
    }

  }
}