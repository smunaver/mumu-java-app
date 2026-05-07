#!/bin/bash

echo "Updating system..."

sudo apt update

echo "Installing Gradle..."

sudo apt install -y gradle

echo "Installed versions:"

java -version
gradle -version

echo "Environment ready."