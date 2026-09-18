#!/bin/env bash


# install opencode, jcode, codex and claude
if command -v brew >/dev/null 2>&1; then
    brew install opencode jcode codex claude
    brew install --cask codex
fi
