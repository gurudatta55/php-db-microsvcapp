#!/usr/bin/env bash
sudo DOCKER_PHP_IMAGE=$1 docker-compose -f /home/ec2-user/deploy-serverconfig/docker-compose.yml up -d