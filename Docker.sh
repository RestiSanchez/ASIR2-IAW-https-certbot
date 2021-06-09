#!/bin/bash

# Actualizamos lista de repositorios
apt update 

# Actualizamos los paquetes
apt upgrade -y

# Instalamos docker

apt install docker -y

# Instalamos docker-compose

apt install docker-compose -y
