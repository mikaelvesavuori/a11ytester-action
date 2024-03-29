#!/bin/bash -l

set -o pipefail

# Set user inputs
URLS="$1"
echo "URLS value is set to: $URLS"

main() {
  echo $URLS >config.json
  urls=$(cat config.json | jq '.[]' -r)

  for url in ${urls[@]}; do
    runTest $url
  done
}

function runTest() {
  URL=$1
  FOLDER=$(echo "$URL" | sed -e 's/[^a-z0-9]//ig' -e 's/https//ig' -e 's/http//gi')

  if [ -z $URL ]; then
    echo "Missing URL!"
    exit 1
  fi

  mkdir -p results/$FOLDER/webhint
  mkdir -p results/$FOLDER/pa11y

  echo "Running Webhint test on $URL..."
  npx hint $URL >results/$FOLDER/webhint/results.txt
  echo "||||||||||||||||||||||"
  echo "||| webhint results ||"
  echo "||||||||||||||||||||||"
  cat results/$FOLDER/webhint/results.txt

  echo "Running pa11y test on $URL..."
  npx pa11y-ci $URL --reporter json >results/$FOLDER/pa11y/results.json
  echo "||||||||||||||||||||||"
  echo "|||| pa11y results |||"
  echo "||||||||||||||||||||||"
  jq '.' results/$FOLDER/pa11y/results.json
}

main "$@"
exit
