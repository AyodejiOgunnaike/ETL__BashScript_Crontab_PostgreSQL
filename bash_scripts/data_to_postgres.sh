#!/bin/bash

# PostgreSQL Credentials
DB_NAME="posey"
DB_USER="postgres"
#DB_PASSWORD="postgres93"
TABLE_NAME="web_events"

# Directory containing CSV files
CSV_DIR="/mnt/c/Users/Administrator/Documents/Projects/Parch_and_Posey"

# Loop through each CSV file in the directory and load it into PostgreSQL
for file in $CSV_DIR/*.csv
do
    psql -h localhost -p 5433 -U $DB_USER -d $DB_NAME -c "\copy $TABLE_NAME FROM '$file' WITH (FORMAT csv, HEADER true)"
    #psql -U $DB_USER -d $DB_NAME -c "\copy $TABLE_NAME FROM '$file' WITH (FORMAT csv, HEADER true)"
    echo "Loaded $file into PostgreSQL database $DB_NAME."
done