#!/bin/bash

# Title:   TTLSet
# Author:  Sapphiress https://github.com/Sapphiress/ttlset
# Date:    28/03/2018
# Version: 0.1

# Check to make sure tool is being run as root.
if [[ $EUID -ne 0 ]]; then
   echo "This tool requires root permissioins. Try again as root." 
   exit 1
fi


# Initialize variables
ttl=46          # This will change to be fluid later on.  It's set as a definate variable for testing.
curttl=0        # Just initializing the variable just to keep all the bases covered.
nan='^[0-9]+$'  # A collection of shit to check if argument is a number.


# Set up $tll
if [[ $1 == "" ]]; then
    echo "You did not specify a ttl, setting to default 46"
    ttl=46
elif [[ $1 == "help"  ]]; then
    echo "Syntax: ttlset [option]"
    echo " "
    echo "Options: "
    echo "help          Displays this text."
    echo "any number    The number you wish to set your ttl to."
    echo " "
    exit 0
elif ! [[ $1 =~ $nan  ]]; then
    echo "You're a monster. That is not a number.  Your ttl must be a number."
    exit 2
else
    echo "You specified a ttl of $1."
    ttl=$1
fi


# Set the TTL While letting the user know what is going on.
echo "Attempting to set the ttl to $ttl..."
sysctl net.ipv4.ip_default_ttl=$ttl > /dev/null # Don't remove >/dev/null this stops the output.

echo "Checking TTL..."
curttl=$(cat /proc/sys/net/ipv4/ip_default_ttl)   # Reads the current ttl and stores it in $curttl.


# Just to confirm that $curttl and $ttl are equal.
echo "The TTL is $curttl."
if [[ $ttl == $curttl ]]; then
    echo "The TTL was set successfully!"
    exit 0
else
    echo "The TTL did not set correctly. Try again!"
    exit 666
fi

