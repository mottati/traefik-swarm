#!/bin/bash
cp /dev/null  traefik.log
cp /dev/null  traefik.access.log
mkdir -p volumes/traefik
mkdir -p volumes/portainer
mkdir -p volumes/influxdb
mkdir -p volumes/grafana

echo ""
echo "Deploy portainer stack."
docker stack deploy -c portainer.yml portainer
echo ""
echo "Deploy traefik stack"
docker stack deploy -c traefik.yml traefik

echo ""
echo "sleep for 10 seconds"
sleep 10
echo ""
echo "Stack info"
docker stack ls 
echo "Docker process info"
docker ps 
echo "Test the influxdb path"
curl http://localhost/influxdb/query?q=SHOW%20DATABASES
echo "" 
echo "Test the portainer path"
curl http://localhost/portainer
echo ""
echo "cat the access log"
cat traefik.access.log 

