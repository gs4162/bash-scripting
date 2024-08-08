#!/bin/bash

project_name=/example
location=/opt

if [ ! -d $location+$project_name ]
then
	echo "creating project folders"
	sudo mkdir -p $location+$project_name
	sudo chown $USER:$USER $location+$project_name
	touch "notes.txt" $location+$project_name #making a folder to keep notes, Also testing the permission of non sudo
fi
echo "Script as come to a end"

