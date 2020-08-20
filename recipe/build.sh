#!/bin/bash

GCC_LIBS=( "libgfortran.3.dylib" "libquadmath.0.dylib" "libgcc_s.1.dylib" )
RPATHS=( "@rpath/." "@rpath" )

for EACH_GCC_LIB in "${GCC_LIBS[@]}"; do
        EACH_GCC_LIB="${PREFIX}/lib/${EACH_GCC_LIB}"

        # Remove hardlinked library files before changing them.
        # This is done so that we don't muck with the user's
        # `gcc` package.
        mv "${EACH_GCC_LIB}" "${EACH_GCC_LIB}_old"
        cp "${EACH_GCC_LIB}_old" "${EACH_GCC_LIB}"
        rm "${EACH_GCC_LIB}_old"

        # Remove existing `LC_RPATH` and change all `@rpath`
        # linked libraries to use their full paths. This is
        # done to "convince" `conda-build` to go back and
        # set the correct `LC_RPATH`s.
        install_name_tool -delete_rpath "@loader_path/" \
                "${EACH_GCC_LIB}"
        for EACH_RPATH in "${RPATHS[@]}"; do
                install_name_tool -change \
                        "${EACH_RPATH}/libgfortran.3.dylib" \
                        "${PREFIX}/lib/libgfortran.3.dylib" \
                        "${EACH_GCC_LIB}"
                install_name_tool -change \
                        "${EACH_RPATH}/libquadmath.0.dylib" \
                        "${PREFIX}/lib/libquadmath.0.dylib" \
                        "${EACH_GCC_LIB}"
                install_name_tool -change \
                        "${EACH_RPATH}/libgcc_s.1.dylib" \
                        "${PREFIX}/lib/libgcc_s.1.dylib" \
                        "${EACH_GCC_LIB}"
        done
done
