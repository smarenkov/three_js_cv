#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo ".env file not found. Exiting..."
    exit 1
fi

# Execute build command
echo "Running build command..."
if ! npm run build; then
    echo "Build failed. Exiting..."
    exit 1
fi

# Deploy files using scp
echo "Deploying files to the server..."
if scp -i ${SSH_KEY} -r dist/* ${SSH_USER}@${SERVER_IP}:${NGINX_HTML_DIRECTORY}; then
    echo "Deployment successful!"
else
    echo "Deployment failed. Please check your credentials and server settings."
    exit 1
fi