# TTLSet
Easy setting of TTL for linux.


Just a very  quick way of setting your ttl.  if your isp requires you to change your ttl every now and then just run "ttlset [number]". "ttlset help" will give you a generic reminder if you can't remember that ;D  Not really that useful but saves one from typing sysctl net.ipv4.ip_default_ttl=number


### Installation:
- Download ttlset.sh
- Open terminal.
- Enter the following commands:
```
sudo cp ~/Downloads/ttlset.sh /usr/sbin/ttlset
```
Then
```sudo chmod +x /usr/sbin/ttlset
```
- That's it you're done.  Just type ttlset just like any other command and you're good to go!
