#!/bin/env bash

# Find where asdf should be installed
ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"
ASDF_COMPLETIONS="$ASDF_DIR/completions"

if [[ ! -f "${ASDF_DIR}/asdf.sh" ]] || [[ -f $(which brew) ]]; then
    echo "[asdf] Installing asdf via brew";
    brew install asdf;
fi

# If not found, check for Homebrew package
if [[ ! -f "$ASDF_DIR/asdf.sh" || ! -f "$ASDF_COMPLETIONS/asdf.bash" ]] && [[ -f $(which brew 2&>1) ]]; then
   ASDF_DIR="$(brew --prefix asdf)"
   ASDF_COMPLETIONS="$ASDF_DIR/etc/bash_completion.d"
fi

# Load command
if [[ -f "$ASDF_DIR/asdf.sh" ]]; then
    . "$ASDF_DIR/asdf.sh"

    # Load completions
    if [[ -f "$ASDF_COMPLETIONS/asdf.bash" ]]; then
        . "$ASDF_COMPLETIONS/asdf.bash"
    fi
fi
