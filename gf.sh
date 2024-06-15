# To find all paramiters urls categary for attack  use ==============   script.sh   file.txt 

#!/bin/bash

# Define the input parameters file
PARAMS_FILE=$1

# Check if a parameters file is provided
if [ -z "$PARAMS_FILE" ]; then
  echo "Usage: $0 <parameters_file>"
  exit 1
fi

# Check if gf is installed
if ! command -v gf &> /dev/null; then
  echo "gf is not installed. Please install it first."
  exit 1
fi

# Create a directory for the output
OUTPUT_DIR="paramiters"
mkdir -p $OUTPUT_DIR

# Define the output files
XSS_OUTPUT="$OUTPUT_DIR/xss.txt"
LFI_OUTPUT="$OUTPUT_DIR/lfi.txt"
SSRF_OUTPUT="$OUTPUT_DIR/ssrf.txt"
SSTI_OUTPUT="$OUTPUT_DIR/ssti.txt"
REDIRECT_OUTPUT="$OUTPUT_DIR/redirect.txt"
SQLI_OUTPUT="$OUTPUT_DIR/sqli.txt"
UPLOAD_OUTPUT="$OUTPUT_DIR/upload.txt"
TAKEOVERS_OUTPUT="$OUTPUT_DIR/takeovers.txt"
CORS_OUTPUT="$OUTPUT_DIR/cors.txt"
IDOR_OUTPUT="$OUTPUT_DIR/idor.txt"
RCE_OUTPUT="$OUTPUT_DIR/rce.txt"
INTERESTINGPARAMS_OUTPUT="$OUTPUT_DIR/interestingparams.txt"
INTERESTINGSUBS_OUTPUT="$OUTPUT_DIR/interestingsubs.txt"

# Find and separate different patterns using gf
echo "[*] Finding and separating patterns..."

cat $PARAMS_FILE | gf xss > $XSS_OUTPUT
cat $PARAMS_FILE | gf lfi > $LFI_OUTPUT
cat $PARAMS_FILE | gf ssrf > $SSRF_OUTPUT
cat $PARAMS_FILE | gf ssti > $SSTI_OUTPUT
cat $PARAMS_FILE | gf redirect > $REDIRECT_OUTPUT
cat $PARAMS_FILE | gf sqli > $SQLI_OUTPUT
cat $PARAMS_FILE | gf upload-fields  > $UPLOAD_OUTPUT
cat $PARAMS_FILE | gf takeovers   > $TAKEOVERS_OUTPUT
cat $PARAMS_FILE | gf cors > $CORS_OUTPUT
cat $PARAMS_FILE | gf idor > $IDOR_OUTPUT
cat $PARAMS_FILE | gf rce > $RCE_OUTPUT
cat $PARAMS_FILE | gf interestingparams > $INTERESTINGPARAMS_OUTPUT
cat $PARAMS_FILE | gf interestingsubs > $INTERESTINGSUBS_OUTPUT


echo "[*] Pattern extraction completed."
echo "XSS URLs saved in: $XSS_OUTPUT"
echo "LFI URLs saved in: $LFI_OUTPUT"
echo "SSRF URLs saved in: $SSRF_OUTPUT"
echo "SSTI URLs saved in: $SSTI_OUTPUT"
echo "Redirect URLs saved in: $REDIRECT_OUTPUT"
echo "Sqli URLs saved in: $SQLI_OUTPUT"
echo "Upload URLs saved in: $UPLOAD_OUTPUT"
echo "Takeovers URLs saved in: $TAKEOVERS_OUTPUT"
echo "Cors URLs saved in: $CORS_OUTPUT"
echo "Idor URLs saved in: $IDOR_OUTPUT"
echo "Rce URLs saved in: $RCE_OUTPUT"
echo "Interestingparams URLs saved in: $INTERESTINGPARAMS_OUTPUT"
echo "Interestingsubs  URLs saved in: $INTERESTINGSUBS_OUTPUT"

find ./paramiters -type f -empty -print -delete
