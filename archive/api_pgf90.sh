#! /bin/bash


#NETCDF=/distrib/local/netcdf-4.0.1/pgi_7.1-6_32/
#NETCDF=/distrib/local/netcdf-4.0.1/pgi_7.1-6_64/
#NETCDF=/distrib/local/netcdf-3.6.0-p1/pgi_64bits/
NETCDF=/donnees/aslmd/MODELES/MESOSCALE_DEV/NETCDF/pgf90_64_netcdf_fpic-3.6.1/

echo $NETCDF

touch logc
touch loge
\rm logc
\rm loge
f2py -c -m api api.F90 --fcompiler=pg -L$NETCDF/lib -lnetcdf -lm -I$NETCDF/include --f90flags="-Mfree" > logc 2> loge
f2py -c -m timestuff time.F --fcompiler=pg >> logc 2>> loge
