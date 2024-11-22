#!/bin/bash

# Get the installed Discord version
discord_version=$(dpkg -l | grep discord | awk '{print $3}')

# Get the latest version of Discord from the HTML response
version_page=$(curl https://discord.com/api/download?platform=linux)  # Follow redirects with -L
latest_version=$(echo "$version_page" | grep -oP '\d+\.\d+\.\d+' | head -n 1)
download_link=$(echo "$version_page" | grep -oP '(?<=href=")[^"]+')

# Function to compare versions
compare_versions() {
    IFS='.' read -r -a installed <<< "$1"
    IFS='.' read -r -a latest <<< "$2"

    for i in {0..2}; do 
        # Correct array indexing
        if [[ ${installed[$i]} -gt ${latest[$i]} ]]; then
            return 0
        elif [[ ${installed[$i]} -lt ${latest[$i]} ]]; then
            return 1
        fi
    done
    return 0
}

compare_versions "$discord_version" "$latest_version"
result=$?

if [ $result -eq 0 ]; then
    echo "The installed version of Discord, Version: $discord_version, is up to date."
else
    echo "A new version of Discord is available: $latest_version. Downloading..."
    curl -o discord.deb "$download_link"
    
    if [[ $? -eq 0 ]]; then
        echo "Download complete. Installing..."
        sudo dpkg -i discord.deb && sudo apt -f install && rm -rf discord.deb
    else
        echo "Error: Failed to download the new version of Discord."
        exit 1
    fi
fi

# Display the installed and latest Discord versions
echo "The discord version installed is: $discord_version"
echo "The latest discord version is: $latest_version"
