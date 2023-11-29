#/bin/bash

sudo systemctl start docker
sudo systemctl start jellyfin
sleep 5
sudo docker start $(sudo docker ps -a -q)
sleep 10
firefox &
sleep 1
firefox --new-tab --url localhost:8686 & # Lidarr
firefox --new-tab --url localhost:7878 & # Radarr
firefox --new-tab --url localhost:8989 & # Sonarr
firefox --new-tab --url localhost:9696 & # Prowlarr
firefox --new-tab --url localhost:9091 & # Transmission
firefox --new-tab --url localhost:8096 & # Jellyfin
jellyfinmediaplayer &

