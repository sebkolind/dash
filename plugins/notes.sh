# Shows recent notes
#
# Variables
# $NOTES_DIR (Required) - Default: null. The path to your .md files.
# $NOTES_LIMIT (Optional) - Default: 5. The amount of notes shown.
#

section "📝  Notes"

if [[ -z "$NOTES_DIR" ]]; then
  empty_state "No notes directory configured. Set NOTES_DIR in your config."
  return
fi

if [[ ! -d "$NOTES_DIR" ]]; then
  empty_state "Notes directory not found: $NOTES_DIR"
  return
fi

# Find the most recently modified files in the notes directory
# Using find with -type f to only get files, sorted by modification time
notes=$(find "$NOTES_DIR" -type f \( -name "*.md" \) -print0 2>/dev/null | \
  xargs -0 stat -f "%m %z %N" 2>/dev/null | \
  sort -rn | \
  head -${NOTES_LIMIT:-5})

if [[ -z "$notes" ]]; then
  empty_state "No notes found in $NOTES_DIR"
  return
fi

echo "$notes" | while read -r mtime size filepath; do
  filename=$(basename "$filepath")

  # Get relative path from NOTES_DIR
  relative_path="${filepath#$NOTES_DIR/}"
  subdir=$(dirname "$relative_path")

  # If in a subdirectory (not root), show the directory
  if [[ "$subdir" != "." ]]; then
    display_name="${subdir}/${filename}"
  else
    display_name="$filename"
  fi

  # Convert bytes to human-readable
  if [[ $size -lt 1024 ]]; then
    size_str="${size}B"
  elif [[ $size -lt 1048576 ]]; then
    size_str="$((size / 1024))KB"
  else
    size_str="$((size / 1048576))MB"
  fi

  # Calculate how long ago the file was modified
  now=$(date +%s)
  diff=$((now - mtime))

  if [[ $diff -lt 3600 ]]; then
    # Less than 1 hour
    minutes=$((diff / 60))
    time_ago="${minutes}m ago"
  elif [[ $diff -lt 86400 ]]; then
    # Less than 1 day
    hours=$((diff / 3600))
    time_ago="${hours}h ago"
  else
    # Days
    days=$((diff / 86400))
    time_ago="${days}d ago"
  fi

  printf "  %s\n" "$display_name"
  printf "  ${BLUE}%s${R} ${DIM}%s${R}\n" "$size_str" "$time_ago"
done
