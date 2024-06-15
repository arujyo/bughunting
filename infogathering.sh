#!/bin/bash

# Define the target domain
DOMAIN=$1

# Check if a domain is provided
if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

# Create a directory for the output
OUTPUT_DIR="subdomain_results"
mkdir -p $OUTPUT_DIR

# Define the output files
ASSETFINDER_OUTPUT="$OUTPUT_DIR/assetfinder.txt"
SUBFINDER_OUTPUT="$OUTPUT_DIR/subfinder.txt"
FINAL_OUTPUT="$OUTPUT_DIR/all_subdomains.txt"
LIVE_OUTPUT="$OUTPUT_DIR/live.txt"
URL_OUTPUT="$OUTPUT_DIR/urls.txt"
# Run assetfinder
echo "[*] Running assetfinder..."
assetfinder --subs-only $DOMAIN > $ASSETFINDER_OUTPUT

# Run subfinder
echo "[*] Running subfinder..."
subfinder -d $DOMAIN -o $SUBFINDER_OUTPUT

# Combine results
echo "[*] Combining results..."
cat $ASSETFINDER_OUTPUT $SUBFINDER_OUTPUT | sort -u > $FINAL_OUTPUT

# Check for live subdomains
echo "[*] Checking for live subdomains..."
cat $FINAL_OUTPUT | httprobe > $LIVE_OUTPUT
# Clean up individual tool outputs if needed
rm $ASSETFINDER_OUTPUT $SUBFINDER_OUTPUT

echo "[*] Subdomain enumeration, live subdomain check, and parameter extraction completed."
echo "All subdomains saved in: $FINAL_OUTPUT"
echo "Live subdomains saved in: $LIVE_OUTPUT"

#aquatone find all live interesting subdomains for you baby 
cat  ./subdomain_results/live.txt | aquatone -out aquatone_results
#Start find all urls using waybackurls 
cat ./aquatone_results/aquatone_urls.txt | waybackurls > urls 
