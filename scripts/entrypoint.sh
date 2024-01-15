#!bin/bash

# force Xorg to use a specific config and run in background
Xvfb :0 &

# Sleep
sleep 1

# # Run gpg agent
gpg-agent --daemon

# # Sleep
sleep 1

# # Run xfce session
xfce4-session &

# # Sleep
sleep 1

# Check if wee have arguments
if [ $# -eq 0 ]; then
  echo "No arguments supplied"
  exit 1
fi

eval "$@"
