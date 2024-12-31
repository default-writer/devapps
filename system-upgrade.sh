#!/bin/bash
set -e
echo WARNING: not tested
exit
# step 1
if [[ ! -f ".step1" ]]; then
  sudo apt update
  sudo apt list --upgradable | more
  sudo apt upgrade
  touch .step1
  exit
fi

# step 2
if [[ ! -f ".step2" ]]; then
  sudo apt install ubuntu-release-upgrader-core
  grep 'lts' /etc/update-manager/release-upgrades
  cat /etc/update-manager/release-upgrades
  sudo ufw allow 1022/tcp comment 'Open port ssh TCP/1022 as failsafe for upgrades'
  sudo ufw status
  sudo /sbin/iptables -I INPUT -p tcp --dport 1022 -j ACCEPT
  touch .step2
  exit
fi

# step 3
if [[ ! -f ".step3" ]]; then
  sudo do-release-upgrade -d
  touch .step3
  exit
fi
