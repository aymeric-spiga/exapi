#! /bin/bash

#NETCDF=/distrib/local/netcdf-4.0.1/g95_4.0.3_64/
#echo $NETCDF

touch logc
touch loge
\rm logc
\rm loge
f2py -c -m api api.F90 --fcompiler=g95 -L$NETCDF/lib -lnetcdf -lm -I$NETCDF/include --f90flags="-Wall -Wno=112,141,137,155 -fno-second-underscore -ffree-form" > logc 2> loge
f2py -c -m timestuff time.F --fcompiler=g95 >> logc 2>> loge
