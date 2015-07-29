#!/bin/sh

echo "Setting up Bluetooth module..."

sudo apt-get install -y  bluetooth bluez-utils blueman

sudo gpasswd -a pi bluetooth

sudo hciconfig hci0 up

sudo hciconfig set name Hyub

sudo hciconfig hci0 piscan

sudo /etc/init.d/bluetooth restart 

mac_addr=`/usr/sbin/hciconfig | grep 'BD' | cut -d ' ' -f3`

echo "mac_addr : $mac_addr is catched"

echo "Make bluetooth module discoverable..."

echo "onmode discoverable" >> /var/lib/bluetooth/$mac_addr/config

echo "mode discoverable" >> /var/lib/bluetooth/$mac_addr/config

echo "discovto 0" >> /var/lib/bluetooth/$mac_addr/config
sudo sed -i 's/raspberrypi/Thin-Gateway/' /var/lib/bluetooth/$mac_addr/config


dir_name="/home/MyProject/"
if test -d $dir_name
then 
echo "Thin-Gateway operating..."
java -jar /home/MyProject/TG0706.jar
else
echo "Setting up Thin-Gateway module..."
git clone https://github.com/hyub0216/MyProject.git
echo "Thin-Gateway operating..."
java -jar /home/MyProject/TG0706.jar
fi
