bkup=~/.dotfile_bkup
dest=~/
source=$(pwd)

echo ${source}

echo "making a backup of old dotfiles"
mkdir -p $bkup
ls -A ~/ | grep ^\\..* | xargs -I file cp ~/file $bkup

echo "loading modules"
git submodule init
git submodule update

echo "linking dotfiles..."
ls -A ${source} | xargs -I file cp --symbolic-link -r ${source}/file ${dest}
