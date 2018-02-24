#!/bin/bash
IFS='\n\t'
set -euo pipefail

source="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dest="$(pwd)"
bkup="$dest/.home_bkup"


if [ -d ${bkup} ]; then
  echo "A backup folder already exists, it must be moved/deleted before bootstrap can apply the new dotfiles."
  exit -1;
fi

echo ""
echo "Making a backup of old dotfiles into ${bkup}..."
mkdir -p "${bkup}"

IFS=$'\n'
if [ -f ${dest}/.ssh/config ]; then
  mkdir -p "${bkup}/.ssh"
  cp "${dest}/.ssh/config" "${bkup}/.ssh/config"
fi
for file in $(ls -lA "${source}" | grep "^-" | awk '{print $9}'); do
  if [ -f "${dest}/${file}" ]; then
    cp "${dest}/${file}" "${bkup}/${file}"
  fi
done

echo ""
echo "loading git modules in $source..."
pushd $source
git submodule init
git submodule update
popd

echo ""
echo "copying \"./tools\" directories..."
if [ -z "${dest}/Tools" ]; then
  mkdir -p ${dest}/tools
fi

#ln -fs  ${source}/Tools ${dest}/tools
cp -R ${source}/tools ${dest}/tools


echo ""
echo "linking dotfiles from ${source} into ${dest}"
# ln on windows pretty much only works with hardlinks it seems
ls -lA "${source}" | grep "^-" | awk '{print $9}' | xargs -I file ln -fs "${source}/file" "${dest}/file"
if [ -z "${dest}/.ssh" ]; then
  mkdir -p "${dest}/.ssh"
fi

echo ""
echo "setting up ssh default"
# a check to see if they're using a config file and if it has a host setup
if [ -f "${dest}/.ssh/config" && -z $(cat "${dest}/.ssh/config" | grep "[hH]ost \*") ]; then
  echo "Appending ssh config"
  # we append it so we don't destroy any custom settings they may have
  cat "${source}/.ssh/config" >> "${dest}/.ssh/config"
elif [ -f "${dest}/.ssh/config" ]; then
  echo "Your SSHfu is strong, skipping config copy..."
else 
  echo "Copying new ssh config"
  mkdir -p "${dest}/.ssh/"
  cp -n "${source}/.ssh/config" "${dest}/.ssh/"
fi


echo ""
echo "installing platform stuff"
if [ $(uname -s) == "Darwin" ]; then
  echo "installing fonts"
  find ${source}/tools/modules/powerline-fonts | grep "\.[to]tf" | xargs -I {} cp {} /Users/$(whoami)/Library/Fonts/

  echo "installing osx stuff"
  sudo ./install/.osx

  #rake
  #~/tools/vim/bundle/YouCompleteMe/install.py --all

elif [ $(uname -s) == "Linux" ]; then
  echo "installing linux stuff"
  sudo ./install/debian.sh
elif [ $(uname -o) == "Msys" ]; then

  echo "If you would like to install vim plugins, ensure you have ruby 1.9.3 + rake installed and do the following:"
  echo "rake;"
  echo "~/tools/vim/bundle/YouCompleteMe/install.py --all;"
  echo "installing fonts"
  fonts="$(find ${source}/tools/modules/powerline-fonts | grep "\.[to]tf")"

  mkdir -p "$dest/fonts_to_install"
  for font in $fonts 
  do
    fontname="$(basename $font)"
    cp -n $font "$dest/fonts_to_install/"
    #reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Fonts" /v "${fontname} (TrueType)" /t REG_SZ /d "$font" /f
  done
  echo "go to $dest/fonts_to_install, select all of the font files and right-click -> install"
fi

mkdir ~/.extensions
cat <<EOF >~/.extensions/README.md
# Extensions

All script files in this folder get loaded by the .profile, so this is a nice place to organize plugins
or enhancements to the dotfile setup
EOF

if [ -f "~/.bashrc" ]; then
  echo "sourcing .profile in .bashrc"
  echo "source ./.profile" >> ~/.bashrc
fi


echo ""
echo "Cleaning up..."
cleanup=".git
.gitmodules
.gitignore
install
bootstrap.sh
remove.sh
README.md"

for f in ${cleanup}
do
  filetorm=${dest}/${f};
  if [ -f  ${filetorm} ]; then
    rm -rf $filetorm
  fi
done


echo ""
echo "To uninstall, do cd ./lauging-hipster && ./remove.sh"
echo "Make sure your home_bkup folder is present, so keep it safe in the meantime!"
echo "Install ./tools/modules/powerline-fonts and set them up in your terminal to benefit from the custom PS1 in .shell_colors"
echo "done!"
