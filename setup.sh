#!/bin/bash

service_file=docker-compose.service
working_path=$(pwd)

if [ "$1" == "install" ]; then
	echo "Configuring service"
	sed -i "s|WorkingDirectory=|WorkingDirectory=$working_path|" $service_file

	echo "Enabling service"
	cp $service_file /etc/systemd/system/$service_file
	systemctl enable $service_file

	echo "Starting service"
	systemctl start $service_file
elif [ "$1" == "uninstall" ]; then
	echo "Disabling service"
	systemctl disable $service_file

	echo "Stopping service"
	systemctl stop $service_file

	echo "Deleting systemd service file"
	rm /etc/systemd/system/$service_file
else
	echo "Missing argument:"
	echo "Usage: ./$0 <install | uninstall>"
fi
