#!/bin/bash -l

set -o pipefail

echo "Installing pa11y..."
npm install -g pa11y

echo "Installing Webhint..."
npm install -g hint
npm install @hint/formatter-json --save-dev
