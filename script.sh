#!/bin/bash -l

set -o pipefail

# Set user inputs
URLS="$1"
echo "URLS value is set to: $URLS"

main() {
  echo $URLS >config.json
  urls=$(cat config.json | jq '.[]' -r)

  for url in ${urls[@]}; do
    bash a11ytest.sh $url
  done
}

main "$@"
exit
