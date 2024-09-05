#!/bin/bash

# Set environment variables
DATA_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"  # Adjusted for WSL

# Step 1: Extract
mkdir -p raw transformed gold
echo "Directories created: raw, transformed, gold."

# Download the file
curl -o raw/annual-enterprise-survey-2023-financial-year-provisional.csv $DATA_URL

# Check if the file was successfully downloaded
if [ -f "raw/annual-enterprise-survey-2023-financial-year-provisional.csv" ]; then
    echo "File downloaded successfully to the raw directory."
else
    echo "File download failed."
    exit 1
fi

# Step 2: Transform
awk -F"," '
BEGIN {OFS=","}
NR==1 {
    for(i=1;i<=NF;i++) {
        if ($i == "Variable_code") $i = "variable_code";
        cols[$i] = i;
    }
    print "Year", "Value", "Units", "variable_code"
}
NR>1 {print $cols["Year"], $cols["Value"], $cols["Units"], $cols["variable_code"]}
' raw/annual-enterprise-survey-2023-financial-year-provisional.csv > transformed/2023_year_finance.csv

if [ -f "transformed/2023_year_finance.csv" ]; then
    echo "File transformed successfully and saved to the transformed directory."
else
    echo "File transformation failed."
    exit 1
fi

# Step 3: Load
cp transformed/2023_year_finance.csv gold/
if [ -f "gold/2023_year_finance.csv" ]; then
    echo "File loaded successfully to the gold directory."
else
    echo "File load failed."
    exit 1
fi

echo "ETL process completed successfully."
