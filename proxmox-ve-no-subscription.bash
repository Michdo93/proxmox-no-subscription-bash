#!/bin/bash
# Enterprise-Repositories deaktivieren (falls vorhanden)
if [ -f /etc/apt/sources.list.d/pve-enterprise.list ]; then
    mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.bak
fi
if [ -f /etc/apt/sources.list.d/pve-enterprise.sources ]; then
    mv /etc/apt/sources.list.d/pve-enterprise.sources /etc/apt/sources.list.d/pve-enterprise.sources.bak
fi

if [ -f /etc/apt/sources.list.d/ceph.list ]; then
    mv /etc/apt/sources.list.d/ceph.list /etc/apt/sources.list.d/ceph.list.bak
fi
if [ -f /etc/apt/sources.list.d/ceph.sources ]; then
    mv /etc/apt/sources.list.d/ceph.sources /etc/apt/sources.list.d/ceph.sources.bak
fi

# Haupt-Sources sichern
mv /etc/apt/sources.list /etc/apt/sources.list.bak

# Debian 13 (Trixie) Repositories schreiben
cat <<EOL | tee /etc/apt/sources.list
deb http://ftp.debian.org/debian trixie main contrib
deb http://ftp.debian.org/debian trixie-updates main contrib

# security updates
deb http://security.debian.org/debian-security trixie-security main contrib
EOL

# Proxmox VE 9 No-Subscription Repository (Debian Trixie)
cat <<EOL | tee /etc/apt/sources.list.d/pve-no-subscription.list
deb http://download.proxmox.com/debian/pve trixie pve-no-subscription
EOL

# Ceph Repository (Squid für PVE 9)
cat <<EOL | tee /etc/apt/sources.list.d/ceph.list
deb http://download.proxmox.com/debian/ceph-squid trixie no-subscription
EOL

apt update
apt upgrade -y
apt dist-upgrade -y
