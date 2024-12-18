#!/bin/bash

echo -e "\e[1;34m
           _   _ _   _ _____ ______  _____  ____  _  __
          | \\ | | \\ | |  __ \\| ___ \\|  ___|/ __ \\| |/ /
          |  \\| |  \\| | |  \\/| |_/ /| |__ / / _  | ' / 
          | . \` | . \` | | __ |  __/ |  __|| |_| ||  <  
          | |\\  | |\\  | |_\\ \\| |    | |___\\ \\_/ /| . \\ 
          \\_| \\_|_| \\_|\\____/\\_|    \\____/ \\___/ |_|\\_\\
 ⋆ ——————————————————————————————————————————————————— ⋆
   X : https://x.com/NoworkNoresult  
 ⋆ ——————————————————————————————————————————————————— ⋆
\e[0m"


sudo apt-get update -y && sudo apt-get upgrade -y

wget https://github.com/hemilabs/heminetwork/releases/download/v0.8.0/heminetwork_v0.8.0_linux_amd64.tar.gz
tar xvf heminetwork_v0.8.0_linux_amd64.tar.gz
cd heminetwork_v0.8.0_linux_amd64/

./popmd --help

./keygen -secp256k1 -json -net="testnet" > ~/popm-address.json


ADDRESS_JSON=$(cat ~/popm-address.json)
ETH_ADDRESS=$(echo "$ADDRESS_JSON" | grep -Po '"ethereum_address":\s*"\K[^"]+')
PRIVATE_KEY=$(echo "$ADDRESS_JSON" | grep -Po '"private_key":\s*"\K[^"]+')
PUBLIC_KEY=$(echo "$ADDRESS_JSON" | grep -Po '"public_key":\s*"\K[^"]+')
PUBKEY_HASH=$(echo "$ADDRESS_JSON" | grep -Po '"pubkey_hash":\s*"\K[^"]+')

export POPM_BTC_PRIVKEY=$PRIVATE_KEY
export POPM_STATIC_FEE=50
export POPM_BFG_URL=wss://testnet.rpc.hemi.network/v1/ws/public


SERVICE_FILE="/etc/systemd/system/hemi.service"

sudo bash -c "cat > $SERVICE_FILE" <<EOL
[Unit]
Description=Hemi Network Daemon
After=network.target

[Service]
Type=simple
ExecStart=/root/heminetwork_v0.8.0_linux_amd64/popmd
WorkingDirectory=/root/heminetwork_v0.8.0_linux_amd64/
Environment=POPM_BTC_PRIVKEY=$PRIVATE_KEY
Environment=POPM_STATIC_FEE=50
Environment=POPM_BFG_URL=wss://testnet.rpc.hemi.network/v1/ws/public
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload
sudo systemctl enable hemi.service
sudo systemctl start hemi.service

echo "Ethereum Address: $ETH_ADDRESS"
echo "Private Key: $PRIVATE_KEY"
echo "Public Key: $PUBLIC_KEY"
echo "Public Key Hash: $PUBKEY_HASH"
