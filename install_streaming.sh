#/bin/bash

# Setup Docker
read -r -p "Setup Docker and Jellyfin? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	yay -S gnome-terminal docker jellyfin-server jellyfin-media-player
	sudo systemctl disable docker.service
	sudo systemctl disable containerd.service
	sudo systemctl disable docker.socket
	sudo systemctl start docker
fi

# Setup Docker
read -r -p "Setup Docker-Desktop? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	wget https://desktop.docker.com/linux/main/amd64/129061/docker-desktop-4.25.2-x86_64.pkg.tar.zst
	sudo pacman -U ./docker-desktop-4.25.2-x86_64.pkg.tar.zst
	sudo systemctl disable docker-desktop
	sudo systemctl start docker-desktop
fi

# Setup Folders
read -r -p "Setup Folders? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	sudo mkdir -p /media/{Docker,Downloads,Backups,Music,Movies,Shows}
	sudo mkdir -p /media/Docker/{Sonarr,Radarr,Lidarr,Prowlarr,Transmission,Flaresolverr}
	sudo chown -R 1000:1000 /media/
	sudo chown root:root /media
	mkdir -p ~/.config/Stream
fi

# Copy Files
read -r -p "Copy Files To OS? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	cp docker-compose.yml /media/Docker/docker-compose.yml
	cp start.sh ~/.config/Stream/start.sh
	cp stop.sh ~/.config/Stream/stop.sh
	chown 1000:1000 ~/.config/Stream/start.sh
	chown 1000:1000 ~/.config/Stream/stop.sh
	chown 1000:1000 /media/Docker/docker-compose.yml
	sudo chmod +x ~/.config/Stream/start.sh
	sudo chmod +x ~/.config/Stream/stop.sh
	read -p "Please Change Username and Passord for transmission.... Press enter to continue to editor"
	vi /media/Docker/docker-compose.yml
fi

# Setup Compose
read -r -p "Setup Compose? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	cd /media/Docker/
	docker compose up -d
	sleep 10
	firefox --new-tab --url localhost:9096 # Lidarr
	firefox --new-tab --url localhost:9095 # Radarr
	firefox --new-tab --url localhost:9094 # Sonarr
	firefox --new-tab --url localhost:9093 # Flaresolverr
	firefox --new-tab --url localhost:9092 # Prowlarr
	firefox --new-tab --url localhost:9091 # Transmission
fi