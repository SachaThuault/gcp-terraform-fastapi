#!/bin/bash

# # Define the flag file path
# FLAG_FILE="/var/log/fastapi-startup-executed"

# Get the project ID from gcloud
PROJECT_ID=$(gcloud config get-value project)
export PROJECT_ID

# # Check if the script has already been executed
# if [ -f $FLAG_FILE ]; then
#     gsutil cp gs://$PROJECT_ID-bucket-data/main.py .
#     echo "Startup script has already been executed. Reloading and starting FastAPI service."
#     sudo systemctl daemon-reload
#     sudo systemctl start fastapi
#     sudo systemctl enable fastapi
#     exit 0
# fi

# If the script hasn't run before, proceed with installation and setup
echo "Executing startup script for the first time."

# Update and install necessary packages
sudo apt update
sudo apt install -y python3 python3-pip

# Write the FastAPI application to main.py
gsutil cp gs://$PROJECT_ID-bucket-data/main.py .
gsutil cp gs://$PROJECT_ID-bucket-data/movie.sql .
gsutil cp gs://$PROJECT_ID-bucket-data/insert_sql_movies.py .
gsutil cp gs://$PROJECT_ID-bucket-data/requirements.txt .

# Install python libraries
pip3 install -r requirements.txt

# Set up the FastAPI application directory
APP_DIR="/home/$(whoami)/fastapi_app"
mkdir -p "$APP_DIR"
cd "$APP_DIR"

# Add ~/.local/bin to PATH in current session
export PATH=$PATH:~/.local/bin

# Get the absolute path of the uvicorn executable
UVICORN_PATH=$(which uvicorn)

# Run the insert SQL movies script
python3 insert_sql_movies.py

# Create a systemd service file for FastAPI
sudo tee /etc/systemd/system/fastapi.service > /dev/null << EOL
[Unit]
Description=FastAPI App
After=network.target

[Service]
User=$(whoami)
Group=www-data
WorkingDirectory=$APP_DIR
Environment="PATH=$APP_DIR/.local/bin:/usr/local/bin:/usr/bin:/bin"
Environment="PROJECT_ID=$PROJECT_ID"
ExecStart=$UVICORN_PATH main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd to recognize the new service, start it, and enable it to start at boot
sudo systemctl daemon-reload
sudo systemctl start fastapi
sudo systemctl enable fastapi

# Create the flag file to indicate successful execution
# touch $FLAG_FILE

