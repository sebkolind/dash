# Plugins
# A small script loaded as a section
#
# Can be configured with a plugin-specific `.config/dash/plugins/{plugin_name}.sh` file.

load_config() {
  local plugin_name="$1"
  local file="${CONFIG_DIR}/plugins/${plugin_name}.sh"
  if [[ -f "$file" ]]; then
    debug "Loading config for plugin: $plugin_name"
    source "$file"
  fi
}

# No plugins configured
if [[ "${#D_PLUGINS[@]}" -eq 0 ]]; then
  echo ""
  printf "  You have no plugins configured. Available plugins:\n"
  printf "  ${BLUE}Jira${R} (jira), ${BLUE}GitHub${R} (pull-requests & review-pull-requests).\n\n"
  printf "  You can configure plugins by adding them to your ${BLUE}D_PLUGINS${R} array in your config file.\n"
  printf "  Your config file is located at: ${CONFIG_DIR}/config.sh.\n"
  return
fi

# Load plugins
for plugin in "${D_PLUGINS[@]}"; do
  load_config "$plugin"
  source "./plugins/$plugin.sh"
done
