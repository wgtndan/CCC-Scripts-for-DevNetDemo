#!/bin/bash

AGENT_LOCATION="/opt/appdynamics/"
APPD_CONTROLLER="10.68.116.252"
APPD_CONTROLLER_PORT="8090"
APPD_CONTROLLER_SSL_ENABLED=""
APPD_ACCESS_KEY="b3752e96-3971-4c62-8540-dafc1175e2d7"
APPD_ACCOUNT_NAME="customer1"
DEPLOYMENT_NAME="Machines"
APP_NAME="devnet-opencart"
TIER_NAME="opencartApp"

. /usr/local/osmosix/service/utils/agent_util.sh

agentSendLogMessage "Installing AppDynamics Agent..."

# Setting the script to exit immediately on any command failure
set -e
set -o pipefail

# Add Host file entry for appd-controller
# sudo echo '<IP>	appd-controller' | sudo tee --append /etc/hosts > /dev/null

#Downloading the AppD Agent
echo "Downloading the AppDynamics App Agent..."
cd /tmp/
mkdir appd-php
cd /tmp/appd-php
wget -O appdynamics-php-agent-x64-linux-4.4.1.343.tar.bz2 http://10.68.116.159/appd/appdynamics-php-agent-x64-linux-4.4.1.343.tar.bz2; touch /tmp/appd-php/downloadagent.done &

#Check if download is done then proceed to unzip the agent package
while [ ! -f /tmp/appd-php/downloadagent.done ]
	do
	 sleep 10
done

# Install the AppD Agent
echo "Installing the AppDynamics App Agent..."
tar -xvjf appdynamics-php-agent-x64-linux-4.4.1.343.tar.bz2
cd appdynamics-php-agent-linux_x64
chmod 777 logs/
sudo ./install.sh -a=${APPD_ACCOUNT_NAME}@${APPD_ACCESS_KEY} $APPD_CONTROLLER $APPD_CONTROLLER_PORT $APP_NAME $TIER_NAME $cliqrNodeHostname

# Restart apache httpd
echo "Restarting HTTP Service..."
sleep 10
sudo service httpd restart

# Clean up the temporary file and the agent package file
echo "Cleaning files... AppDynamics App Agent..."
rm -rf /tmp/appd-php/downloadagent.done
rm -rf /tmp/appd-php/appdynamics-php-agent-x64-linux-4.4.1.343.tar.bz2

agentSendLogMessage "Installing AppDynamics Agent...done"