#!/bin/bash

set -e

sudo mkdir --parents /etc/vault.d
sudo mv vault.hcl /etc/vault.d/vault.hcl
sudo chown --recursive vault:vault /etc/vault.d
sudo chmod 640 /etc/vault.d/vault.hcl

sudo mkdir --parents /opt/vault/data
sudo mkdir --parents /opt/vault/raft/data
sudo chown --recursive vault:vault /opt/vault/

sudo systemctl enable vault.service
sudo systemctl restart vault.service
sleep 5
sudo systemctl status vault.service --no-pager 