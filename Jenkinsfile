pipeline {
    agent any

    stages {
        stage('Hello World') {
            steps {
                helloWorld('Ankit')
            }
        }

        stage('Hello Jenkins') {
            steps {
                script {
                    def util = new org.example.Utils(this)
                    util.sayHelloJenkins()
                }
            }
        }
    }
}
