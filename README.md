# Discord Updater

## Description

This is meant to be a discord auto updater script for Ubuntu machines that downloaded the Discord debian package for
ubuntu. It is worth noting that although it might work on other debian based distros this **hasn't been tested** on any
other platform except for Ubuntu **24.04.1 LTS.**


## Setting Up

Download the Zip file from the repo or clone the repository to your local environment by running  the following command
```bash
git clone https://repository/url.git
```

### Create a process
From your terminal run the following command (__It is not required that you use nano. You can use any text editor you're comfortable with__)

```bash
sudo nano /etc/systemd/system/discord_updater.service
```
Add the following to code to the newly created service

```txt
[Unit]
Description=Discord Updater Script
After=network.target

[Service]
ExecStart=/path/to/your/script.sh #Add the correct path to your username
Restart=on-failure
User=boaz # Remember to use your own username

[Install]
WantedBy=multi-user.target
```
### Enable the Service
```bash
sudo systemctl enable discord_updater.service
```

### Finally start the service
```
sudo systemctl start discord_updater.service
```

## Conclusion
That's all hope you have fun.

Report any bugs [here](mailto:boazmaroko123@gmail.com).



