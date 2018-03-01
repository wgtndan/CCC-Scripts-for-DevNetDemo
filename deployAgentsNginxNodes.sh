#!/bin/bash

#Deploy Machine Agent
wget -e use_proxy=yes -e https_proxy=http://sngidc-dmz-wsa-1.cisco.com/ -O - https://raw.githubusercontent.com/wgtndan/CCC-Scripts-for-DevNetDemo/master/InstallAppdMachineAgent.sh | sudo bash


#Deploy NGINX Agent
wget -e use_proxy=yes -e https_proxy=http://sngidc-dmz-wsa-1.cisco.com/ -O - https://raw.githubusercontent.com/wgtndan/CCC-Scripts-for-DevNetDemo/master/installAppDNginxAgent.sh | sudo bash

