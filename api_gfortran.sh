#! /bin/bash

which f2py

NETCDF=$HOME/PROGRAMS/netcdf-4.0.1-gfortran
echo $NETCDF

f2py  -c -m api api.F90 --fcompiler=gnu95 \
  -L$NETCDF/lib -lnetcdf \
  -lm -I$NETCDF/include \
  --f90flags="-Wall -ffree-form -fno-second-underscore" \
  --include-paths $NETCDF/include:$NETCDF/lib \
  --verbose \
  > api.log 2>&1
f2py -c -m timestuff time.F --fcompiler=gnu95 > timestuff.log 2>&1
