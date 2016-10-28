# Currently working through Chapter 3

# This file is intended to be run on AWS EC2 'Ubuntu Server 14.04 LTS (HVM), SSD Volume Type - ami-ed82e39e
# This creates the first swarm manager for an environment using docker 1.12 or higher

# Step 1) Spin up a fresh Ubuntu 14.04 LTS EC2 instance
# 2) Switch to root: ~$ sudo -s
# 3) Clone this github repo to /home/ubuntu (The repo will make the dir: TAOM-Docker-Swarm)
# 4) Chmod +x this file
# 5) Cd TAOM-Docker-Swarm
# 6) Run this file ~/TAOM-Docker-Swarm# ./setup-swarm-manager-services.sh

apt-get update && apt-get upgrade -y
apt-get install -y apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
rm /etc/apt/sources.list.d/docker.list -f
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge -y lxc-docker
apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
apt-get update
apt-get install -y docker-engine
service docker start
privateIp=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
docker swarm init --advertise-addr $privateIp:2377 --listen-addr $privateIp:2377

# Swarm is now up and running with one manager and one worker. (Both the same -this- docker host)

# Build images

docker build -t img_riemanna images/riemanna
docker build -t img_riemannb images/riemannb 
docker build -t img_riemannmc images/riemannmc

# Create an overlay network 
docker network create --driver overlay TAOM-Network

# Create docker services
docker service create --name riemanna --replicas 1 --network TAOM-Network img_riemanna
docker service create --name riemannb --replicas 1 --network TAOM-Network img_riemannb  
docker service create --name riemannmc --replicas 1 --network TAOM-Network img_riemannmc
