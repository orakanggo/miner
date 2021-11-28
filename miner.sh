#!/bin/bash -e

echo "Entering Screen Mining"
screen -S mining

echo "Get XMRig v6.16.0"
wget https://github.com/xmrig/xmrig/releases/download/v6.16.0/xmrig-6.16.0-macos-x64.tar.gz
tar -zxvf xmrig-6.16.0-macos-x64.tar.gz

echo "Set Huge Pages"

# https://xmrig.com/docs/miner/hugepages#onegb-huge-pages

sysctl -w vm.nr_hugepages=$(nproc)
sudo bash -c "echo vm.nr_hugepages=$(nproc) >> /etc/sysctl.conf"

for i in $(find /sys/devices/system/node/node* -maxdepth 0 -type d);
do
    echo 3 > "$i/hugepages/hugepages-1048576kB/nr_hugepages";
done

echo "1GB pages successfully enabled"

cd xmrig-6.16.0
mv config.json config_.json
wget https://github.com/orakanggo/miner/blob/main/config.js

echo "Done."
echo "Jangan lupa update worker..."
