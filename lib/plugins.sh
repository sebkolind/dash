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

# Load plugins
for plugin in "${D_PLUGINS[@]}"; do
  load_config "$plugin"
  source "./plugins/$plugin.sh"
done
