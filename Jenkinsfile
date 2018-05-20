pipeline {
  agent any
  stages {
    stage('hoge') {
      parallel {
        stage('hoge') {
          steps {
            sh 'echo "hoge"'
          }
        }
        stage('fuga') {
          steps {
            sh 'echo "fuga"'
          }
        }
        stage('piyo') {
          steps {
            sh 'echo "piyo"'
          }
        }
      }
    }
    stage('foo') {
      steps {
        sh 'echo "foo"'
      }
    }
  }
}