source=$(pwd)
bkup=~/dotfile_bkup
dest=~


mkdir -p $bkup
echo "making a backup of old dotfiles into ${bkup}"
ls -A ${dest} | grep ^\\..* | xargs -I file cp ~/file ${bkup}/file

echo "loading modules"
git submodule init
git submodule update

echo "linking dotfiles from ${source} into ${dest}"
cd ${dest}
ls -A ${source} | xargs -I file cp --symbolic-link -r ${source}/file ${dest}

rm -rf ~/.git
rm -rf ~/bootstrap.sh

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash

source ~/.profile
