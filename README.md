# Marketing Training Stack

Mautic, Magento and Wordpress deployment for learning purposes.

### Requirements

- **CPU:** 4 cores, 2GHz
- **RAM:** 4GB
- **Docker:**  [Get Docker CE for Ubuntu - Docker Docs](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- **Git:** `sudo apt install git`



### Installation

You can use the installation script in order to setup your server.  I will install, enable and start the systemd service required to recover from server reboots.	

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



### How to use

##### Install Magento

##### Save/Load Backups

##### Show Logs

