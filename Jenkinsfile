pipeline 
{
  environment { 
   NAME = "mynginx"
   VERSION = "${env.BUILD_ID}"
   IMAGE = "${NAME}:${VERSION}"
}
    
    agent any

    stages
    {
        stage('Envinroment Cleanup ')
        {
            steps{
                echo 'stop container'
              
            }
        }
        stage('Code Clone') 
        {
            steps {
                  echo 'Cloning code...'
                  echo "Running ${VERSION} on ${env.JENKINS_URL}"
                  echo "Image name ${IMAGE}"
                 
                  
               
                  git branch: 'master', credentialsId: 'githubcred', url: 'https://github.com/soorajkg/demo.git'
                 
                  sh "ls -lart ./*"
                }
            
        }
        
        stage('Update the build#') 
        {
            steps {
                    sh "sed -i 's/BUILDNUMBER/${VERSION}/g' ./src/index.html"
                 
                }
            
        }
         stage('Build Docker Image') 
        {
            steps {
                    sh 'docker build -t ${IMAGE} .'
                 
                }
            
        }
        stage('Docker test') 
        {
            steps {
                    sh 'container-structure-test test --image ${IMAGE} --config ./test/config.yaml'
                 
                }
            
        }
        stage('Start container') 
        {
            steps {
                    sh 'docker run -d -p 8090:80 --name test${VERSION} ${IMAGE}'
                 
                }
            
        }
        stage ('Sanity Test')
        {
            steps {
                
                echo 'Placeholder to call quality gates hook'
               sh 'sleep 10s'
               sh ''' curl -sL -w "%{http_code}\n" "http://127.0.0.1:8090/" -o /dev/null '''
            }
            
        }
    }
}
