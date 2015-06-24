#!/bin/bash
src=$(pwd)
pushd .. 2&> /dev/null
echo "Uninstalling files..."
ls -lAp $src | grep "^-" | awk '{print $9}' | xargs -n 1 -I file rm -f file

echo ""
echo "Restoring from home bkup..."
ls -lA ./home_bkup | grep "^-" | awk '{print $9}' | xargs -n 1 -P 8 -I file cp home_bkup/file file

echo ""
echo "Cleaning up home backup and tools..."
rm -rf ./home_bkup
rm -rf ./tools

popd 2&> /dev/null
echo ""
echo ".ssh config has been left alone"
echo ""
echo "Restore completed"
