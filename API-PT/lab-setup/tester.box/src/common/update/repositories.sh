#!/bin/bash

set -e

echo "Adding Repositories and Keys"
# Add Kali Repositories
echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" | tee /etc/apt/sources.list
# Add Kali Required Keys
curl -sSL https://archive.kali.org/archive-key.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/kali-archive-keyring.gpg > /dev/null

apt-get update
