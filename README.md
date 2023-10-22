# `a11ytester-action`

Runs [Webhint](https://webhint.io) and [pa11y](https://pa11y.org) (accessibility testing tools) on one or more provided URLs. Results will be output into the logs of the action.

## Notices

This action is entirely dependent on tools running as intended in GitHub Actions (i.e. a CI platform), which is somewhat flaky, unfortunately.

This action _will currently not break_ when accessibility problems occur. The good side of this is that many typical sites will exhibit a fairly high ratio of "false positives" and similar.

Lastly, note that this action is a subset of the "full" [a11ytester](https://github.com/mikaelvesavuori/a11ytester) project, since GitHub Actions seems incapable of running Lighthouse.

## Required input arguments

### `urls`

One or more escaped URLs in the format (single) `'[\"www.google.com\"]'` or (multiple) `'[\"www.google.com\",\"www.reddit.com\"]'`.

## An example of how to use this action in a workflow

```yml
on: [push]

jobs:
  accessibility:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: a11ytester
        uses: mikaelvesavuori/a11ytester-action@v1
        with:
          urls: '[\"www.google.com\"]'
```

## Optional configurations for Webhint and Pa11y

Example configurations for the tools are below. These files should reside in the repository utilizing the action.

### `.hintrc`

```json
{
  "extends": ["accessibility", "web-recommended"],
  "formatters": ["json"],
  "connector": {
    "name": "puppeteer",
    "options": {
      "headless": true
    }
  }
}
```

### .pa11yci

```json
{
  "defaults": {
    "concurrency": 4,
    "standard": "WCAG2AA",
    "runners": ["axe"]
  }
}
```