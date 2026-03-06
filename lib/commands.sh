# Parse watch mode first
WATCH_MODE=false
WATCH_INTERVAL=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --watch|-w)
      WATCH_MODE=true
      if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
        WATCH_INTERVAL="$2"
        shift
      fi
      shift
      ;;
    --sync|-s)
      rm -f /tmp/dash_*.json
      shift
      ;;
    --update|-u)
      sh "${DIR}/install.sh"
      exit 0
      ;;
    --help|-h)
      echo "Usage: ds [options]"
      echo "  -s, --sync          Clear cache and force a fresh fetch"
      echo "  -w, --watch [N]     Auto-refresh every N seconds (default: 30)"
      echo "  -u, --update        Update to the latest version"
      echo "  -h, --help          Show this help message"
      exit 0
      ;;
    *)
      shift
      ;;
  esac
done
