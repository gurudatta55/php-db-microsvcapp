pipeline {
    agent none
    environment {
        IMAGE_NAME='gurudattaaws/box1:php-2.0'
        BUILD_SERVER_IP='ec2-user@172.31.15.187'
        DEPLOY_SERVER_IP='ec2-user@172.31.5.136'
    }

    stages{
        stage('build and push the image on build server'){
            agent any
        steps{
            script{
            sshagent(['build-server-key']) {
        
        
        withCredentials([usernamePassword(credentialsId: 'docker_credentials', passwordVariable: 'password', usernameVariable: 'username')]) {
                            
        echo "building the docker image"
        sh "scp -o strictHostKeyChecking=no -r build-serverconfig ${BUILD_SERVER_IP}:/home/ec2-user"
        sh "ssh -o strictHostKeyChecking=no ${BUILD_SERVER_IP}:/home/ec2-user/build-serverconfig/docker-script.sh"
        //sh "ssh sudo chmod +x ${BUILD_SERVER_IP} /home/ec2-user/build-serverconfig/dockerscript.sh"
        sh "ssh ${BUILD_SERVER_IP} sudo docker build -t ${IMAGE_NAME} -f /home/ec2-user/build-serverconfig"
        sh "ssh ${BUILD_SERVER_IP} sudo docker login -u $username -p $password"
        sh "ssh ${BUILD_SERVER_IP} sudo docker push ${IMAGE_NAME}"


}
                        


            }

                }
            }
        }

        stage('deploy container on deploy server'){
            agent any
        steps{
            script{
            sshagent(['build-server-key']) {
        
        
        withCredentials([usernamePassword(credentialsId: 'docker_credentials', passwordVariable: 'password', usernameVariable: 'username')]) {
                            
        echo "containerising the docker image"
        sh "scp -o strictHostKeyChecking=no -r deploy-serverconfig ${DEPLOY_SERVER_IP}:/home/ec2-user"
        sh "ssh -o strictHostKeyChecking=no ${DEPLOY_SERVER_IP} bash /home/ec2-user/build-serverconfig/docker-script.sh"
        
        
        sh "ssh ${DEPLOY_SERVER_IP} sudo docker login -u $username -p $password"
        sh "ssh ${DEPLOY_SERVER_IP} bash /home/ec2-user/deploy-serverconfig/compose-script.sh ${IMAGE_NAME}"


}
                        


            }

                }
            }
        }
    }

}
