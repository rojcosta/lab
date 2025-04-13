pipeline {
    agent any
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
                docker build --no-cache -t lab .
            """
        } } }
    }
    //post {
    //    // Clean after build
    //    always {
    //        cleanWs(cleanWhenNotBuilt: false,
    //                deleteDirs: true,
    //                disableDeferredWipeout: true,
    //                notFailBuild: true,
    //                patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
    //                           [pattern: '.propsfile', type: 'EXCLUDE']])
    //    }
    //}
}
