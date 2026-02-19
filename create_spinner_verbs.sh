#!/usr/bin/env bash

COUNT=${1:-500}

# Check if fortune exists
fortune -s >/dev/null 2>&1 || {
  echo "fortune not installed"
  exit 1
}

echo '"spinnerVerbs": {'
echo '  "mode": "replace",'
echo '  "verbs": ['

for i in $(seq 1 "$COUNT"); do
  # Get a short fortune, flatten to one line, strip problematic chars
  line=$(fortune -s -o | tr '\n' ' ' | sed 's/"/'\''/g' | sed 's/[^a-zA-Z0-9 .,!?'\''-]//g')

  printf '    "%s"' "$line"

  if [ "$i" -lt "$COUNT" ]; then
    echo ','
  else
    echo
  fi
done

echo '  ]'
echo '}'
