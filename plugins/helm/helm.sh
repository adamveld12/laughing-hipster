#!/bin/env bash
HELM_VERSION=${HELM_VERSION:-"latest"};

if ! [[ -f "$(which helm 2>&1)" ]] && [[ -d "${HOME}/.asdf" ]]; then
    asdf plugin add helm;
    asdf install helm ${HELM_VERSION};
    asdf local helm ${HELM_VERSION};
fi

if [[ -f "$(which helm 2>&1)" ]]; then
  source <(helm completion bash)
fi
