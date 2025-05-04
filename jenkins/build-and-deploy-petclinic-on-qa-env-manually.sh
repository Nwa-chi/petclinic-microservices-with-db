# PATH="$PATH:/usr/local/bin:$HOME/bin"
# APP_NAME="petclinic"
# APP_REPO_NAME="clarusway-repo/petclinic-app-qa"
# AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
# export AWS_REGION="us-east-1"
# ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
# echo 'Packaging the App into Jars with Maven'
# . ./jenkins/package-with-maven-container.sh
# echo 'Preparing QA Tags for Docker Images'
# . ./jenkins/prepare-tags-ecr-for-qa-docker-images.sh
# echo 'Building App QA Images'
# . ./jenkins/build-qa-docker-images-for-ecr.sh
# echo "Pushing App QA Images to ECR Repo"
# . ./jenkins/push-qa-docker-images-to-ecr.sh
# echo 'Deploying App on Kubernetes Cluster'
# . ./jenkins/deploy_app_on_qa_environment.sh
# echo 'Deleting all local images'
# docker image prune -af
PATH="$PATH:/usr/local/bin:$HOME/bin:/usr/local/helm"  # Add Helm to PATH
APP_NAME="petclinic"
APP_REPO_NAME="clarusway-repo/petclinic-app-qa"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export AWS_REGION="us-east-1"
ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

# Verify Helm is installed
if ! command -v helm &> /dev/null; then
    echo "Installing Helm..."
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
fi

echo 'Packaging the App into Jars with Maven'
. ./jenkins/package-with-maven-container.sh
echo 'Preparing QA Tags for Docker Images'
. ./jenkins/prepare-tags-ecr-for-qa-docker-images.sh
echo 'Building App QA Images'
. ./jenkins/build-qa-docker-images-for-ecr.sh
echo "Pushing App QA Images to ECR Repo"
. ./jenkins/push-qa-docker-images-to-ecr.sh
echo 'Deploying App on Kubernetes Cluster'
. ./jenkins/deploy_app_on_qa_environment.sh  # Now Helm will work!
echo 'Deleting all local images'
docker image prune -af