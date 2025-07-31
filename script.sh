#!/bin/bash

# This script installs Jenkins on Ubuntu 24.04 LTS.

echo "Starting Jenkins installation on Ubuntu 24.04..."

# Step 1: Update the apt package list
echo "Updating package lists..."
sudo apt update -y

# Step 2: Install Java Development Kit (JDK 17) - Jenkins prerequisite
echo "Installing OpenJDK 17 JRE..."
sudo apt install -y openjdk-17-jre

# Verify Java installation
if java -version &> /dev/null; then
    echo "Java 17 installed successfully."
else
    echo "Error: Java 17 installation failed. Exiting."
    exit 1
fi

# Step 3: Add Jenkins repository key
echo "Adding Jenkins GPG key..."
# Download the Jenkins GPG key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Step 4: Add Jenkins repository to sources list
echo "Adding Jenkins repository to /etc/apt/sources.list.d/jenkins.list..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Step 5: Update apt package list again to include Jenkins repository
echo "Updating package lists after adding Jenkins repository..."
sudo apt update -y

# Step 6: Install Jenkins
echo "Installing Jenkins..."
sudo apt install -y jenkins

# Step 7: Start Jenkins service
echo "Starting Jenkins service..."
sudo systemctl start jenkins
