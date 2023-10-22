#!/bin/bash -l

set -o pipefail

echo "Installing pa11y..."
npm install -D pa11y-ci

echo "Installing Webhint..."
npm install -D hint
npm install -D @hint/formatter-json --save-dev
