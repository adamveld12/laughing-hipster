#!/bin/env bash
if [[ -f "$(which helm 2&>1)" ]]; then
  source <(helm completion zsh)
fi
