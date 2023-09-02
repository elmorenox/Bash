#!/bin/bash
# Description: This script updates apt package mange with package information and upgrades upgradable packages.
# Frequency: Every Friday at 11pm, * 23 * * 5. Use `crontab -e` to see cronjobs
# Outputs: ~/server_update/update.%m.%d.%y.txt
# Author: Luis Moreno
# Date: 8/31/2023

# Setting output file's name
output_file="update$(date +'%m.%d.%y').txt"

# Setting error logs name
log="log$(date +'%m.%d.%y').txt"

# Fetch number of upgradeable packages and redirect to output file
sudo apt update | tail -n 1 | cut -d '.' -f 1 > "$output_file"

# Set first line to a variable so we can use in if statement
first_line=$(head -n 1 "$output_file")

# If there are updates add upgradeable packages to output
if [ "$first_line" != "All packages are up to date" ]; then
    # Add list of upgradeable files to output file
    echo -e "Upgrading the following packages \n" && sleep 3 &&
    sudo apt list --upgradeable | cut -d '/' -f 1 >> "$output_file"
    cat "$output_file"
else
    echo -e "\nThis script will check for upgrades next week"
    exit 1
fi

# Upgrade packages and answer yes to any prompts
sudo apt upgrade -y
