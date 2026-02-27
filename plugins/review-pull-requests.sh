section "👀  Review Requests"

check_dependencies gh

review_prs=$(gh search prs --review-requested=@me --state=open --json number,title,repository,author --limit 5 2>/dev/null)

if [ -z "$review_prs" ] || [ "$review_prs" = "[]" ]; then
  empty_state "No reviews waiting—inbox zero!"
else
  echo "$review_prs" | jq -r '.[] | "\(.number)|\(.title)|\(.repository.name)"' 2>/dev/null | while IFS='|' read -r number title repo; do
    title=$(echo "$title" | head -c 34)
    printf "  ${BLUE}#%-5s${R} %-34s ${DIM}%s${R}\n" "$number" "$title" "$repo"
  done
fi
