# OS X Firewall command line helpers

The OS X Application Firewall can feel very much like it's just in the way when developing applications that listens for incoming connections.

Here are some helper scripts to manipulate the AFW via command line to allow your executables to open incoming connections.

# Use of _sudo_

_sudo_ must be used when invoking `/usr/libexec/ApplicationFirewall/socketfilterfw`, so these helper scripts will by default attempt to use _sudo_.


