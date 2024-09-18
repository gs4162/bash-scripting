#!/bin/bash

# Set the master output directory
master_output_dir="/mnt/state-less-hhd/organized_media"

# Input directories (can add more directories here)
input_dirs=(
  "/mnt/state-less-hhd/temp-media-copied-backup/kylee27"
  "/mnt/state-less-hhd/temp-media-copied-backup/graysons"
  "/mnt/state-less-hhd/google-takeout/Takeout"
  "/mnt/state-less-hhd/temp-media-copied-backup"
  "/mnt/state-less-hhd/master-media"
)

# Function to generate SHA-256 hash of the file and get the first 6 digits
generate_hash() {
  local file_path="$1"
  sha256sum "$file_path" | awk '{print substr($1, 1, 6)}'
}

# Function to organize files into the master directory
organize_and_copy() {
  local file_path="$1"
  local output_dir="$2"
  local file_ext=$(echo "${file_path##*.}" | tr '[:upper:]' '[:lower:]')
  
  # Extract the creation date of the file
  local creation_date=$(stat -c %y "$file_path" | cut -d ' ' -f 1)
  local year=$(date -d "$creation_date" +%Y)
  local month=$(date -d "$creation_date" +%m)

  # Determine if the file is a photo or video
  local media_type="other"
  if [[ "$file_ext" =~ ^(jpg|jpeg|png|gif|heic|tiff)$ ]]; then
    media_type="photo"
  elif [[ "$file_ext" =~ ^(mp4|mov|avi|mkv|m4v)$ ]]; then
    media_type="video"
  fi

  # Create the target directory
  local target_dir="$output_dir/$year/$month/$media_type"
  mkdir -p "$target_dir"

  # Generate the target file name with the first 8 characters of the base name and the hash
  local base_name=$(basename "$file_path")
  local short_base_name=$(echo "${base_name%.*}" | cut -c 1-8)
  local hash=$(generate_hash "$file_path")
  local target_file="$target_dir/${short_base_name}_$hash.$file_ext"

  # Check if the target file already exists
  if [[ -e "$target_file" ]]; then
    echo "File already exists: $target_file (Skipping)"
  else
    # Copy the file to the target directory and preserve the original timestamps
    cp -p "$file_path" "$target_file"
    echo "Copied: $file_path -> $target_file"
  fi
}

# Main script
for input_dir in "${input_dirs[@]}"; do
  echo "Processing directory: $input_dir"
  
  # Find and process all files in the input directory and subdirectories
  find "$input_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.heic" -o -iname "*.tiff" -o -iname "*.mp4" -o -iname "*.mov" -o -iname "*.avi" -o -iname "*.mkv" -o -iname "*.m4v" \) | while read -r file_path; do
    organize_and_copy "$file_path" "$master_output_dir"
  done
done

echo "Finished organizing and copying files."
