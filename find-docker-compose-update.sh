#!/bin/bash

dir=/opt
file="docker-compose.y*ml" #both yaml & yml
logs=$(pwd)/logs

#check log directory & permissions

if [ ! -d $logs ]
then
    sudo mkdir $logs
    sudo chown $USER $logs
fi
sudo find $dir -type f -name $file