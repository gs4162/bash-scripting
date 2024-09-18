#!/bin/bash

# this script generates a list of random passwords.

# a random number as a password

password=$RANDOM

echo $RANDOM

# three random numbers together.

echo $RANDOM$RANDOM$RANDOM

# curremt date/time as the password

PASSWORD=$(date +%s)
echo $PASSWORD

# use nanoseconds to act as random

PASSWORD=$(date +%s%N)
echo $PASSWORD

# long password piped into sha256
PASSWORD=$(date +%s%N | sha256sum | head -c 32)

echo $PASSWORD

# evenlonger password
PASSWORD=$(date +%s%N$RANDOM$RANDOM | sha256sum | head -c 55) 
echo $PASSWORD

#append a special charactor
SPECIAL_CHARACTORS='#$%^&*+_)('



SPECIAL_CHARACTOR=$(echo $SPECIAL_CHARACTORS | fold -w1 | shuf | head -n1)

PASSWORD=$(date +%s | sha256sum | head -c 22)

PASSWORD="$PASSWORD$SPECIAL_CHARACTOR"

echo $PASSWORD
