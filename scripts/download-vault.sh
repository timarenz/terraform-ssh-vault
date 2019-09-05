#!/bin/bash

set -e

GPG_KEY=91A6E7F85D05C65630BEF18951852D87348FFC4C
KEY_SERVER=hkp://keyserver.ubuntu.com:80

echo "Vault version: ${VAULT_VERSION}"

gpg --keyserver "${KEY_SERVER}" --recv-keys "${GPG_KEY}"

echo "Downloading Vault binaries from releases.hashicorp.com..."
curl --silent --remote-name https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
curl --silent --remote-name https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS
curl --silent --remote-name https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig

gpg --batch --verify vault_${VAULT_VERSION}_SHA256SUMS.sig vault_${VAULT_VERSION}_SHA256SUMS
grep vault_${VAULT_VERSION}_linux_amd64.zip vault_${VAULT_VERSION}_SHA256SUMS | sha256sum -c 

unzip -o vault_${VAULT_VERSION}_linux_amd64.zip