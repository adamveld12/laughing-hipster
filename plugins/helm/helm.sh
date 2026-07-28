#!/bin/env bash
HELM_VERSION=${HELM_VERSION:-"latest"};

if declare -F asdf_ensure_tool >/dev/null 2>&1; then
    asdf_ensure_tool helm "${HELM_VERSION}" "https://github.com/Antiarchitect/asdf-helm.git";
fi

if command -v asdf >/dev/null 2>&1 && asdf which helm >/dev/null 2>&1; then
  source <(helm completion bash)
fi


helm-setup-plugins() {
    helm plugin install https://github.com/databus23/helm-diff
    helm plugin install https://github.com/jkroepke/helm-secrets --version v3.12.0
}
