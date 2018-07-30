# Marketing Training Stack

Mautic, Magento and Wordpress deployment for learning purposes.

### Requirements

- **CPU:** 4 cores, 2GHz
- **RAM:** 4GB
- **Docker:**  [Get Docker CE for Ubuntu - Docker Docs](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- **Docker compose:**  [Install Docker Compose](https://docs.docker.com/compose/install/)
- **Git:** `sudo apt install git`



### Configure and Install

You **must** edit Magento configuration file before installation. Edit `magento.env` and change this variables.

- *MAGENTO_LANGUAGE*: Magento language

- *MAGENTO_TIMEZONE:* Current server timezone
- *MAGENTO_DEFAULT_CURRENCY*: Default currency used by Magento.
	 ***MAGENTO_URL***: IP or Domain name fo server (e.g: http://192.168.8.37 or http://www.magento.com)	
- ***MAGENTO_ADMIN_FIRSTNAME***: Magento admin firstname
- ***MAGENTO_ADMIN_LASTNAME***: Magento admin last name
- ***MAGENTO_ADMIN_EMAIL***: Magento admin email address (e.g: amdin@example.com)
- ***MAGENTO_ADMIN_USERNAME***: Admin username for Magento
- ***MAGENTO_ADMIN_PASSWORD***: Admin password for Magento.

**<u>NOTES:</u>** 

1. variables in bold **must** be changed.
2. You can use `nano` command to edit them. Check this tutorial: https://www.howtogeek.com/howto/42980/the-beginners-guide-to-nano-the-linux-command-line-text-editor/

	nce you have configured Magento editing `magento.env`, you can use the installation script in order to setup your server.  I will install, enable and start the Systemd service required to recover from server reboots.	

```bash
git clone https://github.com/salvacorts/Marketing-Training-Docker-Stack.git
cd Marketing-Training-Docker-Stack/
chmod +x setup.sh
sudo ./setup.sh install
```

You can remove this service by running:

```bash
sudo ./setup.sh uninstall
```

Now that all applications are running for first time, you have to install Magento by running:

```bash
sudo ./post-install.sh intall-magento
```



### How to use

##### Save/Load Backups

It it highly recommendable making a backup when you have installed and configured all the applications. You can save them running:

```bash
sudo ./post-install.sh backup /path/to/save/your/backups
```

If you want to load your backups:

```bash
sudo ./post-install.sh load-backup /path/where/you/saved/the/backups
```

**<u>NOTES:</u>** 

1. When you load backups, all applications will stop working until backups restored.

##### Show Logs

If something is not working as expected, you can check all messages from application by running:

```bash
cd /srv/docker/
sudo docker-compose logs -f
```



### Advanced Concepts:

#### Files:

- **mautic.env**: Mautic container configuration file.
- **magento.env**: Magento container configuration file.
- **wordpress.env:** Wordpress container configuration file.
- **docker-compose.yml**: Container deployment definition.
- **setup.sh:** Installation file.
- **post-install.sh: ** Post-installation file

#### Learn more:

1. **Connect to server with ssh:** https://www.howtogeek.com/311287/how-to-connect-to-an-ssh-server-from-windows-macos-or-linux/
2. **Basics of Linux command line:** https://maker.pro/linux/tutorial/basic-linux-commands-for-beginners
3. **Mounting volumes in Ubuntu:** https://linuxconfig.org/howto-mount-usb-drive-in-linux
