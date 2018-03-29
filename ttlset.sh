#!/bin/bash

# Title:   TTLSet
# Author:  Sapphiress https://github.com/Sapphiress/ttlset
# Email:   SapphiressOne@Gmail.com
# Date:    28/03/2018
# Version: 0.2



# Check to make sure tool is being run as root.
if [[ $EUID -ne 0 ]]; then
   echo "This tool requires root permissions. Try again as root." 
   echo ""
   exit 1
fi


# Initialize variables
ttl=0           # TTL          - The number in which the TTL will be set to.
curttl=0        # Current TTL  - Just initializing the variable just to keep all the bases covered.
nan='^[0-9]+$'  # Not a Number - A collection of shit to check if argument is a number.


# Set up $tll
if [[ $1 == "" ]]; then
    echo "You did not specify a specific TTL, setting to 46"
    ttl=46
elif [[ $1 == "help"  ]]; then
    echo "Syntax: ttlset [option/ttl]"
    echo ""
    echo "Options: "
    echo ""
    echo "help          Displays this text."
    echo "ttl           The number you wish to set your ttl to."
    echo ""
    echo "You may type ttlset by itself.  However, by default it will be set to 46"
    echo ""
    echo "Examples: "
    echo ""
    echo "ttlset 65 or ttlset help"
    echo ""
    exit 0
elif ! [[ $1 =~ $nan  ]]; then
    echo "What are you doing? YOU MONSTER! That wasn't a number! Your TTL must be a number."
    exit 2
else
    echo "You specified a ttl of $1."
    ttl=$1
fi


# Set the TTL while letting the user know what is going on.
echo "Attempting to set the TTL..."
sysctl net.ipv4.ip_default_ttl=$ttl > /dev/null   # Don't remove > /dev/null this stops the output.

echo "Checking..."
curttl=$(cat /proc/sys/net/ipv4/ip_default_ttl)   # Reads the current ttl and stores it in $curttl.


# Just to confirm that $curttl and $ttl are equal.

# echo "The TTL is $curttl."                      # For debugging purposes.
if [[ $ttl == $curttl ]]; then
    echo "The TTL was set successfully!"
    exit 0
else
    echo "The TTL did not set correctly. Try again!"
    exit 666
fi

