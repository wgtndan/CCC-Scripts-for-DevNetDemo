#!/bin/bash

AGENT_LOCATION="/opt/appdynamics/"
APPD_CONTROLLER="10.68.116.252"
APPD_CONTROLLER_PORT="8090"
APPD_CONTROLLER_SSL_ENABLED="FALSE"
APPD_ACCESS_KEY="b3752e96-3971-4c62-8540-dafc1175e2d7"
# APPD_ACCOUNT_NAME=""
DEPLOYMENT_NAME="Machines"

# Setting the script to exit immediately on any command failure
set -e
set -o pipefail

# Add Host file entry for appd-controller if DNS entry not configured
# echo '<IP>	appd-controller' | tee --append /etc/hosts > /dev/null

#Downloading the AppD Agent
echo "Downloading the AppDynamics Nginx Agent..."
cd /tmp/
mkdir appd-nginx-agent
cd /tmp/appd-nginx-agent

wget -O nginx-monitoring-extension-1.1.9.zip http://10.68.116.159/appd/nginx-monitoring-extension-1.1.9.zip; touch /tmp/appd-nginx-agent/downloadagent.done &

#Check if download is done then proceed to unzip the agent package
while [ ! -f /tmp/appd-nginx-agent/downloadagent.done ]
	do
	 sleep 10
done


# Install the AppD NGINXAgent
echo "Installing the AppDynamics NGINX Agent..."
sudo unzip nginx-monitoring-extension-1.1.9.zip -d "/opt/appdynamics/machine-agent/monitors/"
echo "Configuring the AppDynamics NGINX Agent..."
# sed -i.bkp -e "s%<controller-host>%<controller-host>${APPD_CONTROLLER}%g" \
# -e "s%<controller-port>%<controller-port>${APPD_CONTROLLER_PORT}%g" \
# -e "s%<account-access-key>%<account-access-key>${APPD_ACCESS_KEY}%g" \
# -e "s%<controller-ssl-enabled>%<controller-ssl-enabled>${APPD_CONTROLLER_SSL_ENABLED}%g" \
# -e "s%<sim-enabled>false%<sim-enabled>true%g" \
# -e "s%</controller-info>%<application-name>${DEPLOYMENT_NAME}</application-name></controller-info>%g" \
# /opt/appdynamics/machine-agent/conf/controller-info.xml


# Restart Machine Agent
echo "Starting the AppDynamics Machine Agent..."
sleep 10
service appdynamics-machine-agent restart

# Clean up the temporary file and the agent package file
echo "Cleaning files... AppDynamics Machine Agent..."
rm -rf /tmp/appd-nginx-agent/downloadagent.done
rm -rf /tmp/appd-nginx-agent/nginx-monitoring-extension-1.1.9.zip

echo "AppDynamics Machine Agent Installation...done!"
