#/bin/bash

systemctl start docker
systemctl start docker-desktop
sleep 10
firefox --new-tab --url localhost:9096 # Lidarr
firefox --new-tab --url localhost:9095 # Radarr
firefox --new-tab --url localhost:9094 # Sonarr
firefox --new-tab --url localhost:9093
firefox --new-tab --url localhost:9092
firefox --new-tab --url localhost:9091