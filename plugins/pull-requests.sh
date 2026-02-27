section "🦾  My Pull Requests"

check_dependencies gh jq

prs=$(gh search prs --author=@me --state=open --json number,title,repository --limit 5 2>/dev/null)

if [ -z "$prs" ] || [ "$prs" = "[]" ]; then
  empty_state "No open PRs—go ship something!"
else
  echo "$prs" | jq -r '.[] | "\(.number)|\(.title)|\(.repository.nameWithOwner)"' 2>/dev/null | while IFS='|' read -r number title nwo; do
    title=$(echo "$title" | head -c 34)
    repo="${nwo##*/}"
    printf "  ${BLUE}#%-5s${R} %-34s ${DIM}%s${R}\n" "$number" "$title" "$repo"
  done
fi
