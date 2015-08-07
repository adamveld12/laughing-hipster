#!/bin/bash
src=$(pwd)
pushd .. 2&> /dev/null
dest=$(pwd)

if [[ -d "$dest/.home_bkup" ]]; then
  echo "Uninstalling files from ${dest}..."
  ls -lAp $src | grep "^-" | awk '{print $9}' | xargs -n 1 -I file rm -f $dest/file
  echo ""

  echo "Restoring from .home_bkup..."
  ls -lA ./.home_bkup | grep "^-" | awk '{print $9}' | xargs -n 1 -P 8 -I file cp ./.home_bkup/file ./file
  echo ""

  echo "Cleaning up home backup and tools..."
  rm -rf ./.home_bkup
  rm -rf ./tools

  popd 2&> /dev/null
  echo ""

  echo ".ssh config has been left alone"
  echo ""

  echo "Restore completed!"
else
  echo "you don't have a home backup, aborting"
fi
