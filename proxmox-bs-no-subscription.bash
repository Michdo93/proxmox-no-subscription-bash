#!/bin/bash
# Enterprise-Repository deaktivieren (falls vorhanden)
if [ -f /etc/apt/sources.list.d/pbs-enterprise.list ]; then
    mv /etc/apt/sources.list.d/pbs-enterprise.list /etc/apt/sources.list.d/pbs-enterprise.list.bak
fi
if [ -f /etc/apt/sources.list.d/pbs-enterprise.sources ]; then
    mv /etc/apt/sources.list.d/pbs-enterprise.sources /etc/apt/sources.list.d/pbs-enterprise.sources.bak
fi

# Ceph-List (falls vorhanden) sichern
if [ -f /etc/apt/sources.list.d/ceph.list ]; then
    mv /etc/apt/sources.list.d/ceph.list /etc/apt/sources.list.d/ceph.list.bak
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

# PBS 4 No-Subscription Repository (Debian Trixie)
cat <<EOL | tee /etc/apt/sources.list.d/pbs-no-subscription.list
deb http://download.proxmox.com/debian/pbs trixie pbs-no-subscription
EOL

apt update
apt upgrade -y
apt dist-upgrade -y
