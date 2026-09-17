

# 1. Set environment variables
export AWS_REGION="us-west-1"
export REPO_NAME="dea8-dev-west1-ecr-calendly-01"
#export AWS_ACCOUNT_ID="952933884450"
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

# 1. Build image for ECR repository
docker build --platform linux/amd64 -t calendly .

# 2. Tag the local 'calendly' image for your remote ECR repository
docker tag calendly:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/${REPO_NAME}:latest

# 3. Authenticate Docker to AWS ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com


# 4. Push the image to AWS ECR
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/${REPO_NAME}:latest




