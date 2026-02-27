section "📋  Jira"

check_dependencies acli

# TODO: Make statuses configurable
jira_items=$(acli jira workitem search --jql "assignee = currentUser() AND status in ('In Progress', 'Test', 'Selected for Dev', 'On Deck', 'Blocked')" --fields "key,summary,status" --limit 5 --json 2>/dev/null)

if [ -z "$jira_items" ] || [ "$jira_items" = "[]" ]; then
  empty_state "Nothing assigned to you—pick up a ticket!"
else
  echo "$jira_items" | jq -r '.[] | "\(.key)|\(.fields.summary)|\(.fields.status.name)"' 2>/dev/null | while IFS='|' read -r key summary status; do
    summary=$(echo "$summary" | head -c 34)
    case "$status" in
      "In Progress")       badge="${YELLOW}● in progress${R}" ;;
      "Test")              badge="${CYAN}◎ test${R}" ;;
      "Selected for Dev")  badge="${BLUE}◆ selected${R}" ;;
      "On Deck")           badge="${DIM}○ on deck${R}" ;;
      "Blocked")           badge="${RED}✗ blocked${R}" ;;
      *)                   badge="${DIM}○ ${status}${R}" ;;
    esac
    printf "  ${MAGENTA}%-7s${R} %-34s %b\n" "$key" "$summary" "$badge"
  done
fi
