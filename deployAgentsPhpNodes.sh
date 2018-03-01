#!/bin/bash

#Deploy Machine Agent
wget -O - https://raw.githubusercontent.com/wgtndan/CCC-Scripts-for-DevNetDemo/master/InstallAppdMachineAgent.sh | sudo bash


#Deploy PHP Agent
wget -O - https://raw.githubusercontent.com/wgtndan/CCC-Scripts-for-DevNetDemo/master/InstallAppDPHPAgent.sh | sudo bash

