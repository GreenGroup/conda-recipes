#!/bin/sh

#make julia directory
mkdir -p ${PREFIX}/share/julia/site
mkdir -p ${PREFIX}/bin
#set JULIA_DEPOT_PATH in conda env
export JULIA_DEPOT_PATH="${PREFIX}/share/julia/site"
ACTIVATE_ENV="${PREFIX}/etc/conda/activate.d/env_vars.sh"
DEACTIVATE_ENV="${PREFIX}/etc/conda/deactivate.d/env_vars.sh"

if [ -f "$ACTIVATE_ENV" ]; then
        echo 'export JULIA_DEPOT_PATH="${PREFIX}/share/julia/site"' >> $ACTIVATE_ENV
else
        mkdir -p ${PREFIX}/etc/conda/activate.d
        touch ${PREFIX}/etc/conda/activate.d/env_vars.sh
        echo '#!/bin/sh' >> $ACTIVATE_ENV
        echo 'export JULIA_DEPOT_PATH="${PREFIX}/share/julia/site"' >> $ACTIVATE_ENV
fi
if [ -f "$DEACTIVATE_ENV" ]; then
        echo "unset JULIA_DEPOT_PATH" >> $DEACTIVATE_ENV
else
        mkdir -p ${PREFIX}/etc/conda/deactivate.d
        touch ${PREFIX}/etc/conda/deactivate.d/env_vars.sh
        echo '#!/bin/sh' >> $DEACTIVATE_ENV
        echo "unset JULIA_DEPOT_PATH" >> $DEACTIVATE_ENV
fi


set -e
VERSION="1.4.2"

case "$VERSION" in
  nightly)
    BASEURL="https://julialangnightlies-s3.julialang.org/bin"
    JULIANAME="julia-latest"
    ;;
  [0-9]*.[0-9]*.[0-9]*)
    BASEURL="https://julialang-s3.julialang.org/bin"
    SHORTVERSION="$(echo "$VERSION" | grep -Eo '^[0-9]+\.[0-9]+')"
    JULIANAME="$SHORTVERSION/julia-$VERSION"
    ;;
  [0-9]*.[0-9])
    BASEURL="https://julialang-s3.julialang.org/bin"
    SHORTVERSION="$(echo "$VERSION" | grep -Eo '^[0-9]+\.[0-9]+')"
    JULIANAME="$SHORTVERSION/julia-$VERSION-latest"
    ;;
  *)
    echo "Unrecognized VERSION=$VERSION, exiting"
    exit 1
    ;;
esac

case $(uname) in
  Linux)
    case $(uname -m) in
      x86_64)
        ARCH="x64"
        case "$JULIANAME" in
          julia-latest)
            SUFFIX="linux64"
            ;;
          *)
            SUFFIX="linux-x86_64"
            ;;
        esac
        ;;
      i386 | i486 | i586 | i686)
        ARCH="x86"
        case "$JULIANAME" in
          julia-latest)
            SUFFIX="linux32"
            ;;
          *)
            SUFFIX="linux-i686"
            ;;
        esac
        ;;
      *)
        echo "Do not have Julia binaries for this architecture, exiting"
        exit 1
        ;;
    esac
    echo "$BASEURL/linux/$ARCH/$JULIANAME-$SUFFIX.tar.gz"
    cd ${PREFIX}/share/julia/site
    curl -L "$BASEURL/linux/$ARCH/$JULIANAME-$SUFFIX.tar.gz" | tar -xzs
    ln -s $PWD/julia-*/bin/julia ${PREFIX}/bin/julia
    cd ${PREFIX}
    ;;
  Darwin)
    curl -Lo julia.dmg "$BASEURL/mac/x64/$JULIANAME-mac64.dmg"
    hdiutil mount -mountpoint /Volumes/Julia julia.dmg
    cp -Ra /Volumes/Julia/*.app/Contents/Resources/julia ${PREFIX}/share/julia/site
    ln -s ${PREFIX}/share/julia/site/julia/bin/julia ${PREFIX}/bin/julia
    # TODO: clean up after self?
    ;;
  *)
    echo "Do not have Julia binaries for this platform, exiting"
    exit 1
    ;;
esac