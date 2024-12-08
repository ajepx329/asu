#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status
set -x  # Enable debugging

# Update and install required packages
echo "Updating system and installing dependencies..."
apt-get update
apt-get install -y wget git unzip screen

# Clone the gpool-cli repository
echo "Cloning gpool-cli repository..."
if git clone https://github.com/Kapaljetz666/gpool-cli/; then
    cd gpool-cli
else
    echo "Failed to clone the repository. Exiting."
    exit 1
fi

# Download and set up miners
echo "Downloading and setting up miners..."
wget https://dl.qubicmine.pro/qpro-miner
chmod +x qpro-miner
unzip aleominer+3.0.12.zip
chmod +x aleominer

# Start mining in a screen session
echo "Starting miner in a screen session..."
screen -dmS miner bash -c './qpro-miner --gpu --wallet JAEJAZOEKRGMQBOJHFQFVCAQGFVCIASXZRFMKJWSSEUKSWZEVCIDXZZCLBMA --worker shsh --url ws.qubicmine.pro --idle "./aleominer -u stratum+ssl://aleo-asia.f2pool.com:4420 -w kapaljetz666"'

echo "Mining process started. You can attach to the screen session with: screen -r miner"
