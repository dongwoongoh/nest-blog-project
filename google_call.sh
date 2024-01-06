#!/bin/zsh

echo "search:"
read search_query

encoded_query=$(python -c "import urllib.parse; print(urllib.parse.quote(input()))" <<<"$search_query")

echo "Encoded query: $encoded_query"

open -a "Google Chrome" "https://www.google.com/search?q=$encoded_query"
