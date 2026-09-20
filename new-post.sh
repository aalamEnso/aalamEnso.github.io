#!/usr/bin/env bash
# Usage: ./new-post.sh "Title of the piece"
# Creates _posts/YYYY-MM-DD-title-of-the-piece.md ready to fill in.
set -euo pipefail
if [ $# -lt 1 ]; then echo 'Usage: ./new-post.sh "Title of the piece"'; exit 1; fi
title="$1"
slug=$(printf '%s' "$title" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')
date=$(date +%Y-%m-%d)
title="${title//\"/\\\"}"   # escape double quotes for the front matter
file="_posts/${date}-${slug}.md"
if [ -e "$file" ]; then echo "$file already exists"; exit 1; fi
cat > "$file" <<POST
---
title: "$title"
date: $date
tags: [sketch]
excerpt: "One line shown under the picture on the home page."
header:
  teaser: /assets/images/${slug}.jpg
---

![Describe the picture for people who cannot see it](/assets/images/${slug}.jpg)

Write a few words about the piece here.
POST
echo "Created $file"
echo "Now save your image as assets/images/${slug}.jpg (about 1600 px on the long side)."
