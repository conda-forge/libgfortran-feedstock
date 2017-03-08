#!/bin/bash
# Originally from Continuum's build.sh

LIB=$PREFIX/lib
mkdir $LIB
cd $LIB

cp /usr/lib64/libgfortran.so.3.0.0 .
ln -s libgfortran.so.3.0.0 libgfortran.so.3
