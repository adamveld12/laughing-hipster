#!/bin/sh
# install vim with all of the necessary features
[ ! -s "${HOME}/Projects/vim" ] && git clone --branch v8.1.2109 https://github.com/vim/vim vim
cd ./vim

export VIMRUNTIME=${HOME}/.config/vim/runtime;
echo "setting up vim runtime folder @ ${VIMRUNTIME}";
mkdir -p ${VIMRUNTIME}/autoload ${VIMRUNTIME}/bundle && \
curl -LSso ${VIMRUNTIME}/autoload/pathogen.vim https://tpo.pe/pathogen.vim;


VIM_CONFIG_ARGS='
  --enable-multibyte \
  --enable-rubyinterp=yes \
  --with-python3-config-dir=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu \
  --enable-python3interp=yes \
  --enable-perlinterp=yes \
  --enable-luainterp=yes \
  --disable-netbeans \
  --with-compiledby="Adam V <adam@veldhousen.net>" \
  --enable-gui=auto \
  --enable-cscope \
  --prefix=/usr/local
'

VIM_CONFIG_X_ARGS='
  --enable-gtk2-check \
  --enable-gnome-check \
  --with-x 
'
if [ ! -z "$(which X)" ]; then
    echo "adding X options"
    VIM_CONFIG_ARGS="${VIM_CONFIG_ARGS} ${VIM_CONFIG_X_ARGS}"
fi

./configure ${VIM_CONFIG_ARGS}

make VIMRUNTUMEDIR=${HOME}/.config/vim/runtime/
sudo make install VIMRUNTIMEDIR=${HOME}/.config/vim/runtime/


VIMFILES=/usr/local/share/vim/vim81
find ${VIMFILES} -type f |  \
   sed "s=${VIMFILES}==" | \
   xargs -I {} dirname {} | \
   xargs -I {} mkdir -p ${VIMRUNTIME}{};

find ${VIMFILES} -type f | \
   sed "s=${VIMFILES}==" | \
   xargs -I {} cp $VIMFILES/{} $VIMRUNTIME{};

ln -svf ${HOME}/.config/vim/.vimrc ~/.vimrc

cd ..
rm -rf ./vim

pushd ${HOME}/.config/vim/
rake
popd