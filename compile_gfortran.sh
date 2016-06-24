#! /bin/bash

################################
log="api.log"
NETCDF="./NETCDF/netcdf-4.0.1/"
################################

### LOG FILE
touch $log
\rm $log

################################################################################
################################################################################
echo " get and compile netCDF librairies (please wait)"
\rm -rf NETCDF
mkdir NETCDF
ze_netcdf=netcdf-4.0.1
cd NETCDF
#wget ftp://ftp.unidata.ucar.edu/pub/netcdf/old/$ze_netcdf.tar.gz -a $log
#tar xzvf $ze_netcdf.tar.gz >> $log 2>&1
#\rm $ze_netcdf.tar.gz*
cp ../$ze_netcdf.tar ./
tar xvf $ze_netcdf.tar >> $log 2>&1
export FC=gfortran
export FFLAGS=" -O2 -fPIC"
export F90=gfortran
export FCFLAGS="-O2 -ffree-form -fPIC"
export CPPFLAGS=""
export CC=gcc
export CFLAGS="-O2 -fPIC"
export CXX=g++
export CXXFLAGS="-O2 -fPIC"
cd $ze_netcdf
PREFIX=$PWD
./configure --prefix=${PREFIX} >> $log 2>&1  #--disable-cxx
make >> $log 2>&1
make test >> $log 2>&1
make install >> $log 2>&1
################################################################################
################################################################################

#### COPY/PREPARE SOURCES
#### perform changes that makes f2py not to fail
sed s/"\!"/"\n\!"/g api.F90 | sed s/"\!!"/"\n\!!"/g > tmp.api.F90

### BUILD THROUGH f2py WHAT IS NECESSARY TO CREATE THE PYTHON FUNCTIONS
touch api.pyf
\rm api.pyf
f2py -h api.pyf -m api tmp.api.F90 > api.log 2>&1

#### IMPORTANT: we teach f2py about variables in the call_mcd subroutines which are intended to be out
#sed s/"real :: pres"/"real, intent(out) :: pres"/g fmcd$num.pyf | \
#sed s/"integer :: ier"/"integer, intent(out) :: ier"/g > fmcd$num.pyf.modif
#mv fmcd$num.pyf.modif fmcd$num.pyf

### BUILD
f2py -c api.pyf tmp.api.F90 --fcompiler=gnu95 \
  -L$NETCDF/lib -lnetcdf \
  -lm -I$NETCDF/include \
  --f90flags="-fPIC" \
  --f77flags="-fPIC" \
  --verbose \
  > api.log 2>&1

## CLEAN THE PLACE
\rm tmp.api.F90
