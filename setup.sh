#!/bin/bash

DIR="$(dirname $(realpath $BASH_SOURCE))"
ln -fs ${DIR} ${HOME}/.vim
#ln -fs ${DIR}/vimrc ${HOME}/.vimrc
