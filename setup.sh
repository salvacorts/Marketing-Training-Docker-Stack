#!/bin/bash

service_file=marketing-training.docker.service
install_path=/srv/docker

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

if [ "$1" == "install" ]; then
	echo "Copying compose file to $install_path"
	mkdir -p $install_path
	cp ./*.yml $install_path/
	cp ./*.env $install_path/

	echo "Installing service"
	sed "s|_install_path|$install_path|" $service_file | tee /etc/systemd/system/$service_file

	echo "Enabling service"
	systemctl enable $service_file

	echo "Starting service"
	systemctl start $service_file
elif [ "$1" == "uninstall" ]; then
	echo "Disabling service"
	systemctl disable $service_file

	echo "Stopping service"
	systemctl stop $service_file

	echo "Deleting files"
	rm /etc/systemd/system/$service_file
	rm $install_path/*.yml
	rm $install_path/*.env
else
	echo "Missing argument:"
	echo "Usage: $0 <install | uninstall>"
fi
