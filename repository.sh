#!/bin/bash

# Detect Ubuntu version codename
ubuntu_version=$(lsb_release -cs)

# Backup existing sources based on Ubuntu version
if [ "$ubuntu_version" = "noble" ]; then
  # Ubuntu 24.04 uses DEB822 format in sources.list.d
  if [ -f /etc/apt/sources.list.d/ubuntu.sources ]; then
    sudo cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.backup
  fi
else
  # Older Ubuntu versions use traditional sources.list
  sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
  # Clear the existing sources.list
  sudo truncate -s 0 /etc/apt/sources.list
fi

# Set repositories based on Ubuntu version
case "$ubuntu_version" in
  "bionic")
    echo "Setting repositories for Ubuntu 18.04 (Bionic Beaver)"
    cat <<EOL | sudo tee /etc/apt/sources.list
# Primary Ubuntu repositories
deb https://mirror.xeonbd.com/ubuntu-archive/ bionic main restricted
deb https://mirror.xeonbd.com/ubuntu-archive/ bionic-updates main restricted
deb https://mirror.xeonbd.com/ubuntu-archive/ bionic universe
deb https://mirror.xeonbd.com/ubuntu-archive/ bionic-updates universe
deb https://mirror.xeonbd.com/ubuntu-archive/ bionic multiverse
deb https://mirror.xeonbd.com/ubuntu-archive/ bionic-updates multiverse

# Security updates
deb http://security.ubuntu.com/ubuntu bionic-security main restricted
deb http://security.ubuntu.com/ubuntu bionic-security universe
deb http://security.ubuntu.com/ubuntu bionic-security multiverse

# Optional Backports repository
deb https://mirror.xeonbd.com/ubuntu-archive/ bionic-backports main restricted universe multiverse
EOL
    ;;
  "focal")
    echo "Setting repositories for Ubuntu 20.04 (Focal Fossa)"
    cat <<EOL | sudo tee /etc/apt/sources.list
# Primary Ubuntu repositories
deb https://mirror.xeonbd.com/ubuntu-archive/ focal main restricted
deb https://mirror.xeonbd.com/ubuntu-archive/ focal-updates main restricted
deb https://mirror.xeonbd.com/ubuntu-archive/ focal universe
deb https://mirror.xeonbd.com/ubuntu-archive/ focal-updates universe
deb https://mirror.xeonbd.com/ubuntu-archive/ focal multiverse
deb https://mirror.xeonbd.com/ubuntu-archive/ focal-updates multiverse

# Security updates
deb http://security.ubuntu.com/ubuntu focal-security main restricted
deb http://security.ubuntu.com/ubuntu focal-security universe
deb http://security.ubuntu.com/ubuntu focal-security multiverse

# Optional Backports repository
deb https://mirror.xeonbd.com/ubuntu-archive/ focal-backports main restricted universe multiverse
EOL
    ;;
  "jammy")
    echo "Setting repositories for Ubuntu 22.04 (Jammy Jellyfish)"
    cat <<EOL | sudo tee /etc/apt/sources.list
# Primary Ubuntu repositories
deb https://mirror.xeonbd.com/ubuntu-archive/ jammy main restricted
deb https://mirror.xeonbd.com/ubuntu-archive/ jammy-updates main restricted
deb https://mirror.xeonbd.com/ubuntu-archive/ jammy universe
deb https://mirror.xeonbd.com/ubuntu-archive/ jammy-updates universe
deb https://mirror.xeonbd.com/ubuntu-archive/ jammy multiverse
deb https://mirror.xeonbd.com/ubuntu-archive/ jammy-updates multiverse

# Security updates
deb http://security.ubuntu.com/ubuntu jammy-security main restricted
deb http://security.ubuntu.com/ubuntu jammy-security universe
deb http://security.ubuntu.com/ubuntu jammy-security multiverse

# Optional Backports repository
deb https://mirror.xeonbd.com/ubuntu-archive/ jammy-backports main restricted universe multiverse
EOL
    ;;
  "noble")
    echo "Setting repositories for Ubuntu 24.04 (Noble)"
    # Create the new DEB822 format sources file
    cat <<EOL | sudo tee /etc/apt/sources.list.d/ubuntu.sources
Types: deb
URIs: https://mirror.xeonbd.com/ubuntu-archive/
Suites: noble noble-updates noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: http://security.ubuntu.com/ubuntu/
Suites: noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOL
    ;;
  *)
    echo "Unsupported Ubuntu version or unable to detect version. Please check your system."
    exit 1
    ;;
esac

# Update package lists
sudo apt update

# Upgrade packages
sudo apt upgrade -y

echo "Repositories have been successfully updated and packages upgraded for Ubuntu $ubuntu_version."
