#! /bin/bash


echo $NETCDF

touch logc
touch loge
\rm logc
\rm loge
f2py -c -m api        api.F90   --fcompiler=intelem  -L$NETCDF/lib -lnetcdf -lm -I$NETCDF/include >  logc 2>  loge
#f2py -c -m timestuff  time.F    --fcompiler=intelem                                               >> logc 2>> loge
