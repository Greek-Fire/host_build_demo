#!/bin/bash

# Variables
DB_USER="mock_ui"
DB_PASSWORD="redhat"
DB_NAME="mock_ui"
HOSTNAME="vcenter.lou.land"
IP_ADDRESS=$(hostname -I | awk '{print $1}')

sudo apt update
sudo apt install postgresql postgresql-contrib  nodejs npm libpq-dev git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
sudo systemctl status postgresql

# Create the PostgreSQL user and database
sudo -i -u postgres psql <<EOF
CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
ALTER USER $DB_USER WITH CREATEDB;
CREATE DATABASE $DB_NAME OWNER $DB_USER;
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
EOF
echo "PostgreSQL user and database created successfully."


# Enable UFW
sudo ufw enable

# Allow PostgreSQL port
sudo ufw allow 5432/tcp

# Allow Rails server port
sudo ufw allow 3000/tcp

# Verify the firewall rules
sudo ufw status

echo "Firewall configured to allow traffic on PostgreSQL port 5432 and Rails server port 3000."

echo "$IP_ADDRESS $HOSTNAME" | sudo tee -a /etc/hosts

echo "Added $HOSTNAME with IP $IP_ADDRESS to /etc/hosts."

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

source ~/.bashrc

rbenv install 3.2.0
rbenv global 3.2.0
echo "gem: --no-document" > ~/.gemrc
gem env home

bundle install
gem install rails

rails server -b $IP_ADDRESS -e development

