#!/bin/bash

# ============== #
# print strings
# ============== #
opt_str="[OPTION] "

eC="\033[0m"
GC="\033[1;32m"
yC="\033[0;33m"
aC="\033[0;36m"
rC="\033[0;41m"
gC="\033[0;42m"
oC="\033[3;93m"
mC="\033[0;43m"

help() {
    echo "Usage: $0 [OPTION]"
    echo " "
    echo "  [OPTION]:"
    echo "    -clone      clone all codes for test"
    echo "    -build      build all codes for test"
}

# ============ #
# parse inputs
# ============ #

if [[ $# -lt 1 ]]; then
  help
  exit 1
fi

CLONE=0
BUILD=0
for var in "$@"
do
  if [ "$var" == "--help" -o "$var" == "-help" -o "$var" == "-h" ]; then
    help
    exit 0

  elif [ "$var" == "-clone" ]; then
    echo -e "Found known argument: ${gC}$var${eC}"
    CLONE=1
  
  elif [ "$var" == "-build" ]; then
    echo -e "Found known argument: ${gC}$var${eC}"
    BUILD=1
  fi
done


if [ $CLONE == 1 -o $BUILD == 1 ]; then
  cd codes
fi

# ============== #
# checkout codes #
# ============== #
if [ $CLONE == 1 ]; then
  echo
  echo -e "${aC}Please enter bitbucket username:${eC}"
  read username

  echo  
  echo -e "${yC}Clone cdriver: Yes[y] or No[n]?${eC}"
  read clone_this
  if [ $clone_this == 'y' ]; then
    git clone https://$username@bitbucket.org/wyoming/cdriver.git
    cd cdriver
    git checkout sensei_develop
    cd ..
  fi

  echo
  echo -e "${yC}Clone dg4est-v2: Yes[y] or No[n]?${ec}"
  read clone_this
  if [ $clone_this == 'y' ]; then
    git clone https://$username@bitbucket.org/wyoming/dg4est-v2.git
  fi

  echo
  echo -e "${yC}Clone tioga: Yes[y] or No[n]?${ec}"
  read clone_this
  if [ $clone_this == 'y' ]; then
    git clone https://github.com/jsitaraman/tioga.git
  fi

  echo
  echo -e "${yC}Clone VisIt LIBSIM inteface: Yes[y] or No[n]?${ec}"
  read clone_this
  if [ $clone_this == 'y' ]; then
    git clone https://$username@bitbucket.org/wyoming/visit_libsim_interface.git
  fi
fi


# ========== #
# make codes #
# ========== #
if [ $BUILD == 1 ]; then
  # make cdriver
  echo
  echo "Making the driver..."
  cd cdriver
  make
  cp bin/cdriver.mpi ../../lib
  cd ..

  # make dg4est-v2
  echo
  echo "Making dg4est-v2..."
  cd dg4est-v2
  ./build.sh -go
  cp builds/dg4est_release_p3/lib/libdg4est3d.so ../../lib
  cd ..

  # make tioga
  echo
  echo "Making Tioga..."
  cd tioga
  git checkout 0782a27733a2c8f3ad3b1771d02845bb2a6ba7cc .
  cd src
  make shared
  cp libtioga.so ../../../lib
  cd ../../

  # make visit libsim
  #echo
  #echo "Making VisIt LibSim..."
  #cd visit_libsim_interface/visit_extract.v4/
  #make
  #cd ../../
fi
