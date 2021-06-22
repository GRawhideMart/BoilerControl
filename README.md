# BoilerControl
## Introduction
Development of a remote control for a heater via internet. The control action is carried out through a smart relay. Furthermore, a separate room’s temperature is monitored through sensors and the heater will be activated automatically if said temperature falls below a certain threshold.

## Methodologies
Devices and wirings:
* The HMI interface is a Telegram bot;
* The relay of choice is the Sonoff Basic, a smart switch based on ESP which can communicate via WiFi;
* The communication protocol is MQTT;
* The monitoring of the room performed through sensors controlled by an Arduino Uno; the communication happens through a serial port.

### Server setup
The physical machine mounts Ubuntu Server 18.04. It will act as a broker, so it needs Mosquitto installed on it. Then enable the relative daemon to automatically startup using *systemd*; the port used by said daemon is the **1883**. Then we installed *node-red*; *NodeJS* and its package manager *NPM* are essential for this stage.
Thus, we enabled node-red to startup automatically as well; as a result, node-red is operating on port *1880*.  
Next, install the Telegram palette and then add it to node-red through its builtin node manager.
### Device setup
Sonoff Basic is not compatible with MQTT, so it needs an external third party firmware, which can be downloaded [here](https://github.com/arendst/Tasmota/releases). Then, flash the device using the Arduino Uno, which in this scenario acts as a USB/TTY converter.
### Arduino communication
It will publish the temperature on the serial port with a frequency of 1 msg/minute. Please note: Arduino has a few compatibility issues with node-red; to resolve this issue, install the serial port node from [this repository](https://libraries.io/npm/node-red-node-serialport-wildcard).
### node-red Flow
The bot shows a predetermined keyboard with the main commands. The two nodes on top are command nodes, and define the behavior of the two main commands: 
* /accendi sets the topic cmnd/tasmota/power to 1
* /spegni sets the topic cmnd/tasmota/power to 0
 /start, quite self-explicably, starts the interaction between user and bot, while /stato allows the user to retrieve the state of the boiler (ON or OFF).
The receiver block right underneath blocks the user from sending unwanted commands to the bot. Finally, the block at the bottom of the page listens for state changes and sends them to the user through the bot.

## Files
* log.pdf : a self-explainatory log file for the node-red flow;
* Node-RED Debug Tools.html : an html version of the log (better formatted for browser visualization);
* node-red flow.json : the working node-red flow for the bot;
* Physical System.jpg : a picture of the deployed relay;
* serversetup.sh : a shell script for the automation of the Ubuntu Server setup;
