def node_name = "kubernetes"

pipeline {
    agent {
        label "${node_name}"
    }
    options {
        disableConcurrentBuilds()
        parallelsAlwaysFailFast()
        timeout(time: 1, unit: 'HOURS')
    }
    //triggers {
    //    pollSCM('') // Enabling being build on Push
    //}
    stages {
        stage("Stage 01") { steps { script {
            sh """
                id
                pwd
                ls
            """
        } } }
    }
     post {
        // Clean after build
        always {
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true,
                    patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                               [pattern: '.propsfile', type: 'EXCLUDE']])
        }
    }
}
