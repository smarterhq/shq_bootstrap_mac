#!/usr/local/bin/bash
#!/bin/bash

## The only way to increase Max Processes is to install Mac OS Server from the App Store

# Note: To set serverperfmode you will need to reboot your mac in recovery mode (hold down command+R)
# Select your language and then go to utilities and launch a terminal
# Run: csrutil disable
# Reboot into normal mode and run the command below

# sudo nvram boot-args="serverperfmode=1 $(nvram boot-args 2>/dev/null | cut -f 2-)"
# sudo nvram boot-args

# Reboot into recovery mode one more time, repeat steps to launch terminal
# Run: csrutil enable
# Reboot into normal mode and 'profit'!

sudo sysctl -w kern.maxfiles=10485760
sudo sysctl -w kern.maxfilesperproc=10485760
sudo sysctl -w kern.maxprocperuid=10485760

# Configure OSX Sysctl
if [ ! -f "/etc/sysctl.conf" ]; then
  echo "kern.maxfiles=10485760" | sudo tee -a /etc/sysctl.conf
  echo "kern.maxfilesperproc=10485760" | sudo tee -a /etc/sysctl.conf
  echo "kern.maxproc=10485760" | sudo tee -a /etc/sysctl.conf
  echo "kern.maxprocperuid=10485760" | sudo tee -a /etc/sysctl.conf
fi

if [ ! -f "/Library/LaunchDaemons/limit.maxfiles.plist" ]; then
  sudo cp -v Library/LaunchDaemons/limit.maxfiles.plist /Library/LaunchDaemons/
  sudo chown root:wheel /Library/LaunchDaemons/limit.maxfiles.plist
  sudo chmod 644 /Library/LaunchDaemons/limit.maxfiles.plist
fi

if [ ! -f "/Library/LaunchDaemons/limit.maxproc.plist" ]; then
  sudo cp -v Library/LaunchDaemons/limit.maxproc.plist /Library/LaunchDaemons/
  sudo chown root:wheel /Library/LaunchDaemons/limit.maxproc.plist
  sudo chmod 644 /Library/LaunchDaemons/limit.maxproc.plist
fi
