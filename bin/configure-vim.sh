#!/bin/bash

# http://204.152.191.100:8080/wiki/index.php/Configure_options_-_vim
./configure --enable-rubyinterp --enable-pythoninterp --enable-python3interp --enable-perlinterp --enable-cscope --enable-multibyte  --with-features=huge --enable-fontset --enable-xim --with-x --prefix=$HOME/vim
