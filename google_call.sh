#!/bin/zsh

echo "search_query:"
read search_query

encoded_query=$(python -c "import urllib.parse; print(urllib.parse.quote(input()))" <<<"$search_query")

open -a "Google Chrome" "https://www.google.com/search?q=$encoded_query"
