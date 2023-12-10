#/bin/bash

# Setup Docker
read -r -p "Setup Applications? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	yay -S gnome-terminal docker docker-compose jellyfin-server jellyfin-web jellyfin-media-player
	sudo systemctl disable docker.service
	sudo systemctl disable containerd.service
	sudo systemctl disable docker.socket
	sudo systemctl disable jellyfin
	sudo systemctl start docker
	sudo systemctl start jellyfin
fi

# Setup Folders
read -r -p "Setup Folders? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	sudo mkdir -p /media/{Docker,Downloads,Backups,Music,Movies,Shows}
	sudo mkdir -p /media/Docker/{Sonarr,Radarr,Lidarr,Prowlarr,Transmission,Flaresolverr}
	sudo mkdir -p /media/Backups/{Sonarr,Radarr,Lidarr,Prowlarr,Transmission}
	sudo chown -R 1000:1000 /media/Docker
	sudo chown 1000:1000 /media/Downloads
	sudo chown 1000:1000 /media/Backups
	sudo chown 1000:1000 /media/Music
	sudo chown 1000:1000 /media/Movies
	sudo chown 1000:1000 /media/Shows
	mkdir -p ~/.config/Stream
fi

# Copy Files
read -r -p "Copy Files To OS? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	cp docker-compose.yml /media/Docker/docker-compose.yml
	sudo cp -r StreamSystem /usr/share/applications/
	cp Init/lidarr.zip /media/Backups/Lidarr/
	cp Init/radarr.zip /media/Backups/Radarr/
	cp Init/Sonarr.zip /media/Backups/Sonarr/
	cp Init/prowlarr.zip /media/Backups/Prowlarr/
	sudo chmod +x /usr/share/applications/StreamSystem/start.sh
	sudo chmod +x /usr/share/applications/StreamSystem/stop.sh
	sudo chmod +x /usr/share/applications/StreamSystem/start-stream.desktop
	sudo chmod +x /usr/share/applications/StreamSystem/stop-stream.desktop
fi

# Start Compose
read -r -p "Start Compose? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	cd /media/Docker/
	sudo docker compose up -d
	sleep 10
fi

# Open Apps
read -r -p "Open Apps? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	firefox &
	sleep 1
	firefox --new-tab --url localhost:8686 & # Lidarr
	sleep 1
	firefox --new-tab --url localhost:7878 & # Radarr
	sleep 1
	firefox --new-tab --url localhost:8989 & # Sonarr
	sleep 1
	firefox --new-tab --url localhost:8191 & # Flaresolverr
	sleep 1
	firefox --new-tab --url localhost:9696 & # Prowlarr
	sleep 1
	firefox --new-tab --url localhost:9091 & # Transmission
	sleep 1
	firefox --new-tab --url localhost:8096 & # Jellyfin
fi
