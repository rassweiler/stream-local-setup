#/bin/bash

systemctl stop docker.service
systemctl stop containerd.service
systemctl stop docker.socket
systemctl stop docker-desktop