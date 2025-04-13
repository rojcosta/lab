def node_name = "build"

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
        stage("Build") { steps { script {

            def repoUrl = env.GIT_URL
            def repoName = repoUrl.split('/')[-1].replace('.git', '')
            def branchName = env.BRANCH_NAME
            def ingressSuffix = branchName.split('/')[-1]
            def buildId = env.BUILD_ID
            echo "Branch Name: ${branchName}"
            echo "Repository Name: ${repoName}"
            echo "IngressSuffix Name: ${ingressSuffix}"
            sh """
                podman build --no-cache -t ${repoName}-${ingressSuffix}-${buildId} .
            """
        } } }
        stage("Deploy") { steps { script {
            def repoUrl = env.GIT_URL
            def repoName = repoUrl.split('/')[-1].replace('.git', '')
            def branchName = env.BRANCH_NAME
            def ingressSuffix = branchName.split('/')[-1]
            def buildId = env.BUILD_ID
            sh """#/bin/bash
                export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
                kubectl get pods -n defautl
                sed -i "s/image-replace/${repoName}-${ingressSuffix}-${buildId}/g" dev/deployment.yaml
                cat dev/deployment.yaml
                kubectl create ns ${repoName}-${ingressSuffix}
                kubectl -n ${repoName}-${ingressSuffix} apply -f dev/deployment.yaml
                sleep 10
                kubectl -n ${repoName}-${ingressSuffix} get pods
                git status
                git checkout .
                git reset --hard
                git status
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
