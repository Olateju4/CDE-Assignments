#!/bin/bash

# Set environment variable for the CSV file URL
export CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

# Create directories
mkdir -p raw Transformed Gold

# Download the CSV file and save it into the raw folder
echo "Downloading file..."
curl -O raw/annual-enterprise-survey-2023-financial-year-provisional.csv "$CSV_URL"

# Check if the file was downloaded
if [ -f raw/annual-enterprise-survey-2023-financial-year-provisional.csv ]; then
  echo "File downloaded and saved in the raw folder."
else
  echo "Failed to download file."
  exit 1
fi

# Rename column and select specific columns
echo "Transforming file..."
awk -F, 'BEGIN {OFS=","} NR==1 {for (i=1; i<=NF; i++) if ($i=="Variable_code") col=i; print "year", "Value", "Units", "variable_code"} NR>1 {print $1, $2, $3, $col}' raw/data.csv > Transformed/2023_year_finance.csv

# Check if the transformed file was created
if [ -f Transformed/2023_year_finance.csv ]; then
  echo "Transformed file has been saved into the Transformed folder."
else
  echo "Failed to create transformed file."
  exit 1
fi

# Move the transformed file to the Gold directory
echo "Moving transformed file into Gold folder..."
mv Transformed/2023_year_finance.csv Gold/

# Check if the file was moved
if [ -f Gold/2023_year_finance.csv ]; then
  echo "File has been moved to the Gold folder."
else
  echo "Failed to move file to Gold folder."
  exit 1
fi
