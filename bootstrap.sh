#!/bin/bash
IFS='\n\t'
set -euo pipefail

source="$(pwd)"
bkup="$source/../.home_bkup"
dest="$source/.."

echo "Making a backup of old dotfiles into ${bkup}..."
rm -rf "${bkup}"
mkdir -p "${bkup}"

IFS=$'\n'
if [[ -f ${dest}/.ssh/config ]]; then
  mkdir -p "${bkup}/.ssh"
  cp "${dest}/.ssh/config" "${bkup}/.ssh/config"
fi
for file in $(ls -lA "${source}" | grep "^-" | awk '{print $9}'); do
  if [ -f "${dest}/${file}" ]; then
    cp "${dest}/${file}" "${bkup}/${file}"
  fi
done

echo ""
echo "loading git modules..."
git submodule init 
git submodule update

echo ""
echo "copying \"./tools\" directories..."
if [[ -z "${dest}/Tools" ]]; then
  mkdir ${dest}/Tools
fi
#ln -fs  ${source}/Tools ${dest}/tools
cp -R ${source}/tools ${dest}/tools

# sometimes its easier if you just change directories
pushd ${dest} 2&> /dev/null

echo ""
echo "linking dotfiles from ${source} into ${dest}"
# ln doesn't want to work on my windows box, so I'm going to have to figure this out later
ls -lA "${source}" | grep "^-" | awk '{print $9}' | xargs -I file ln -fs "${source}/file" "${dest}/file"
if [[ -z "${dest}/.ssh" ]]; then
  mkdir "${dest}/.ssh"
fi

echo ""
# a check to see if they're using a config file and if it has a host setup
if [[ -f "${dest}/.ssh/config" && -z $(cat "${dest}/.ssh/config" | grep "Host \*") ]]; then
  echo "Appending ssh config"
  # we append it so we don't destroy any custom settings they may have
  cat "${source}/.ssh/config" >> "${dest}/.ssh/config"
elif [[ -z "${dest}/.ssh/config" ]]; then
  echo "Copying new ssh config"
  cp "${source}/.ssh/config" "${dest}/.ssh/config"
else 
  echo "Your SSHfu is strong, skipping config copy..."
fi


echo ""
echo "Cleaning up..."
rm -rf ${dest}/.git
rm -rf ${dest}/.gitmodules
rm -rf ${dest}/.gitignore
rm -rf ${dest}/bootstrap.sh
rm -rf ${dest}/remove.sh
rm -rf ${dest}/README.md

popd 2&> /dev/null
echo "To uninstall, do cd ./lauging-hipster && ./remove.sh"
echo "Make sure your home_bkup folder is present, so keep it safe in the meantime!"
echo "Install ./tools/modules/powerline-fonts and set them up in your terminal to benefit from the custom PS1 in .shell_colors"
echo "done!"
