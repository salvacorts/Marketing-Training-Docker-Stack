#!/bin/bash

service=marketing-training.docker.service

# Backup containers data volumes.
# Arguments:
#	- $1: Backup path
#	- $2: Containers list
function backup {
	args=("$@")
	backup_path="${args[0]}"
	containers=("${args[@]:1}")

	for c in "${containers[@]}"; do
		data_path=$(docker inspect -f '{{ (index .Mounts 0).Source }}' $c)
		backup=$backup_path/$c-data_bak.tar

		mkdir -p $backup_path

		printf "%s: %s -> %s\n" $c $data_path $backup
		tar -cf $backup $data_path
	done
}

# Recover data from volume backup
# Arguments:
#	- $1: Backup path
#	- $2: Containers list
function load_backup {
	args=("$@")
	backup_path="${args[0]}"
	containers=("${args[@]:1}")

	# Shut down all containers
	systemctl stop $service

	for c in "${containers[@]}"; do
		data_path=$(docker inspect -f '{{ (index .Mounts 0).Source }}' $c)
		backup=$backup_path/$c-data_bak.tar

		printf "%s -> %s: %s\n" $backup $c $data_path
		rm -rf $data_path/_data
		tar -xf $backup -C $data_path
	done

	# Start all containers again
	systemctl start $service
}

# Install magento running container installation files
function install_magento {
	docker exec -it magento "install-magento"
	docker exec -it magento "install-sampledata"
}


if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

if [[ $# < 1 ]]; then
	echo "Usage: $0 <backup | load_backup | install-magento>"
	exit
fi

containers=( "mautic" "db-mautic" "magento" "db-magento" "wordpress" "db-wordpress" )

case "$1" in
	"backup")
		if [[ $# < 2 ]]; then
			echo "Usage: $0 backup <absolute_backups_path>"
			exit
		fi

		backup $2 "${containers[@]}"
		;;
	"load_backup")
		if [[ $# < 2 ]]; then
			echo "Usage: $0 load_backup <absolute_backups_path>"
			exit
		fi

		load_backup $2 "${containers[@]}"
		;;
	"install-magento")
		install_magento
		;;
esac
