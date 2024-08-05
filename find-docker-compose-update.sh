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


#permission of logs to be owned by current user

sudo chown $USER $logs
sudo chmod +rw -R $logs 

#update to latest images
current=1

for composes in $(sudo find $dir -type f -name $file)
do echo "Pulling latest files for $composes"
    dir_path=$(dirname "$composes")
    
    cd $dir_path && docker compose pull
    echo "----updating:"$current"----"
    current=$((current +1))
     

done

echo "-----"
echo "End"


