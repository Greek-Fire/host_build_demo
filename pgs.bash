#!/bin/bash
  
# Variables
DB_USER="mock_ui"
DB_PASSWORD="redhat"
DB_NAME="mock_ui"


# Create the PostgreSQL user and database
sudo -i -u postgres psql <<EOF
CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
ALTER USER $DB_USER WITH CREATEDB;
CREATE DATABASE $DB_NAME OWNER $DB_USER;
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
EOF
