FILE="${CONFIG_DIR}/config.sh"
if [[ -f "$FILE" ]]; then
  debug "Loading config: $FILE"
  source "$FILE"
fi
