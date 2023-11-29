#/bin/bash

sudo docker stop $(sudo docker ps -a -q)
sleep 5
sudo systemctl stop docker
sudo systemctl stop docker.socket
sudo systemctl stop containerd.service
sudo systemctl stop jellyfin