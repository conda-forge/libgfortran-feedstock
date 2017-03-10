#!/bin/bash
# Originally from Continuum's build.sh

if [ $(uname) == Linux ]; then
    LIB=$PREFIX/lib
    mkdir $LIB
    cd $LIB
    
    cp /usr/lib64/libgfortran.so.3.0.0 .
    ln -s libgfortran.so.3.0.0 libgfortran.so.3
fi
