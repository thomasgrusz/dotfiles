#!/bin/bash

# Define filename
sunfile="/home/thomasgrusz/.myscripts/sunrise_sunset.txt"

# Latitude and Longitude for Basel, Switzerland
latitude=47.54
longitude=7.56

# Get sun data for Basel from online service
sundata=$(curl -s "https://api.sunrise-sunset.org/json?lat=${latitude}&lng=${longitude}&formatted=0&tzid=Europe/Zurich") 

SUNRISE=$(sed -n 's/.*"sunrise":"\([^"]*\)".*/\1/p' <<< "$sundata")
SUNSET=$(sed -n 's/.*"sunset":"\([^"]*\)".*/\1/p' <<< "$sundata")

rm -f $sunfile

echo $SUNRISE > $sunfile
echo $SUNSET >> $sunfile
