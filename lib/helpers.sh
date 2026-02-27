section() {
  echo ""
  echo -e "  ${BOLD}${CYAN}$1${R}"
}

row() {
  printf "  ${DIM}%-14s${R} %b\n" "$1" "$2"
}

empty_state() {
  echo -e "  ${DIM}$1${R}"
}

check_dependencies() {
  local -a commands=("$@")
  for cmd in "${commands[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
      echo "Missing dependency: $cmd"
      exit 1
    fi
  done
}
