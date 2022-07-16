# `a11ytester-action`

Runs [Webhint](https://webhint.io) and [pa11y](https://pa11y.org) (accessibility testing tools) on one or more provided URLs. Results will be output into the logs of the action.

This action _will currently not break_ when accessibility problems occur. The good side of this is that many typical sites will exhibit a fairly high ratio of "false positives" and similar.

_Note that this action is a subset of the "full" [a11ytester](https://github.com/mikaelvesavuori/a11ytester) project, since GitHub Actions seems incapable of running Lighthouse which, by the way, is actually not very good anyway._

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
        uses: mikaelvesavuori/a11ytester-action@v1.0.0
        with:
          urls: '[\"www.google.com\"]'
```
