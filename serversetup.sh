#!/bin/bash

clear
echo 'INSTALLING BUILD ESSENTIALS'
sudo apt install -y build-essential git python-software-properties

clear
echo 'INSTALLING MOSQUITTO'
sudo apt install -y mosquitto
sudo systemctl enable mosquitto

clear
echo 'DOWNLOADING NODE'
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

clear
echo 'INSTALLING NODEJS'
sudo apt install -y nodejs

clear
echo 'INSTALLING NODE-RED'
sudo npm install -g --unsafe-perm node-red
sudo systemctl enable nodered.service

clear
echo 'INSTALLING TELEGRAM PALETTE'
npm install node-red-contrib-telegrambot
