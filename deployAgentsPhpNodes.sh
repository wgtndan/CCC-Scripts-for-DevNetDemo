#!/bin/bash

#Deploy Machine Agent
wget -O - https://raw.githubusercontent.com/wgtndan/CCC-Scripts-for-DevNetDemo/master/c3-appd-machine-agent-sample.sh | bash


#Deploy PHP Agent
wget -O - https://raw.githubusercontent.com/wgtndan/CCC-Scripts-for-DevNetDemo/master/InstallAppDPHPAgent.sh | bash

