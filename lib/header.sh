if [ "$D_HEADER" = false ]; then
  return
fi

if [ "$D_HEADER_LOGO" = true ]; then
  echo -e "${BOLD}${MAGENTA}  ┌┬┐┌─┐${R}"
  echo -e "${BOLD}${MAGENTA}   ││└─┐${R}"
  echo -e "${BOLD}${MAGENTA}  ─┴┘└─┘${R}"
  echo ""
fi

echo -e "  ${DIM}$(date '+%A, %B %d · %H:%M')${R}"

if [ "$D_HEADER_META" = true ]; then
  [[ $WATCH_MODE = true ]] && wm_str="On" || wm_str="Off"

  meta="  "
  meta+="${DIM}Plugins:${R} ${BOLD}${CYAN}${#D_PLUGINS[@]}${R}"
  meta+="${DIM} ∙ Cache:${R} ${BOLD}${CYAN}${D_CACHE_TTL}s${R}"
  meta+="${DIM} ∙ Watch:${R} ${BOLD}${CYAN}${wm_str}${R}"
  printf "${meta}\n"
fi
