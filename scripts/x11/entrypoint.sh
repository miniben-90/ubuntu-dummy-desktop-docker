#!bin/bash

set -e

ERROR=0

cleanup() {
  echo -e "Cleanup session and close gpg agent..."
  # Logout session
  # xfce4-session-logout
  # Terminate gpg agent
  gpg-connect-agent /bye
}

# Trap the EXIT signal (fires on script exit)
trap cleanup EXIT

trap 'echo -e "\033[0;31mAn error occurred\033[0m"; cleanup' ERR

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
  echo -e "\033[0;31mNo arguments supplied\033[0m"
  exit 1
fi

eval "$@"