#!/bin/bash

dir=/opt
file="docker-compose.y*ml" #both yaml & yml
logs=$(pwd)/logs


#check log directory, create & permissions

if [ ! -d $logs ]
then
    mkdir $logs
    chown $USER $logs
fi
sudo find $dir -type f -name $file

#permission of logs to be owned by current user

sudo chown $USER $logs
sudo chmod +rw -R $logs 