#!/usr/bin/env bash

# @see https://stackoverflow.com/questions/19408649/pipe-input-into-a-script
if command -v delta >/dev/null 2>&1; then
  cat | delta "$@"
else
  cat | less -F -X
fi
