#!/bin/bash
IFS='\n\t'
set -euo pipefail

source=$(pwd)
bkup=~/home_bkup/
dest=~


echo "making a backup of old dotfiles into ${bkup}..."
rm -rf ${bkup}
mkdir -p ${bkup}

IFS=$'\n'
if [[ -f ${dest}/.ssh/config ]]; then
  cp "${dest}/.ssh/config" "${bkup}/.ssh/config"
fi
for file in $(ls -lA "${source}" | grep "^-" | awk '{print $9}'); do
  if [ -f "${dest}/${file}" ]; then
    cp -v "${dest}/${file}" "${bkup}/${file}"
  fi
done

echo ""
echo "loading git modules..."
git submodule init
git submodule update


echo "copying directories..."
cp -rs ${source}/tools ${dest}/tools

pushd ${dest} 2>&1 /dev/null
echo "linking dotfiles from ${source} into ${dest}..."
ls -lA "${source}" | grep "^-" | awk '{print $9}' | xargs -I file ln -vfs "${source}/file" "${dest}/file"
cp "${source}/.ssh/config" "${dest}/.ssh/config"

#set +u
#curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash 
#set -u

echo "cleaning up..."
# cleanup
rm -rf ${dest}/bootstrap.sh
rm -rf ${dest}/.git

popd 2>&1 /dev/null

echo "done!"
