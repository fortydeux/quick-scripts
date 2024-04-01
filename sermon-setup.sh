#!/usr/bin/env bash

# Ask user for YouTube URL
echo -n "Enter YouTube URL: "
read url

# Get video information in json format
info=$(yt-dlp -j "$url")

# Extract upload date and title
upload_date=$(echo "$info" | jq -r '.upload_date')
title=$(echo "$info" | jq -r '.title' | tr ' ' '-')

# Format date and title
formatted_date=$(date -d "$upload_date" +%Y-%m-%d)
folder_title="$formatted_date-$title"

# Create directories
main_download_folder="$HOME/KNC-Audio/Downloads-Audio"
mkdir -p "$main_download_folder/$folder_title/Working"

# Create an empty text file
text_file_path="$main_download_folder/$folder_title/$folder_title.txt"
touch "$text_file_path"

# Write the title, new lines, and "KNC Audio ID: " to the text file
echo "$folder_title" > "$text_file_path"  # Overwrite the file with the title
echo -e "\n\n\nKNC Audio ID: " >> "$text_file_path"  # Append new lines and "KNC Audio ID: "

# Download mp3 audio
yt-dlp --extract-audio --audio-format mp3 -o "$main_download_folder/$folder_title/Working/%(title)s.%(ext)s" "$url"

echo "Download completed!"

