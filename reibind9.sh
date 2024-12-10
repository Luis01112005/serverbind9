sudo docker-compose -f bind9.yml down
sudo docker-compose -f bind9.yml up -d --build 
sudo docker logs  -f bind9-container
