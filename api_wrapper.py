
### A. Spiga -- LMD -- 03/07/2011

import api
import numpy as np

def api_onelevel (  path_to_input   = './', \
                    input_name      = 'wrfout_d0?_????-??-??_??:00:00', \
                    path_to_output  = None, \
                    output_name     = None, \
                    process         = 'list', \
                    fields          = 'tk,W,uvmet,HGT', \
                    debug           = False, \
                    bit64           = False, \
                    oldvar          = True, \
                    interp_method   = 4, \
                    extrapolate     = 0, \
                    unstagger_grid  = False, \
                    interp_level    = [-9999.], \
                    onelevel        = 0.020, \
                    nocall          = False ):

    if not path_to_output:  path_to_output = path_to_input

    if not output_name:
        if interp_method <= 2:    output_name = input_name+'_p'
        if interp_method == 3:    output_name = input_name+'_z'
        if interp_method == 4:    output_name = input_name+'_zabg'

    if interp_level[0] == -9999.:  
        interp_level = np.arange(1000)
    else:                 
        zelen = len(interp_level)
        zetemp = np.zeros(1000)
        zetemp[0:zelen] = interp_level[0:zelen]
        zetemp[zelen] = -99999.
        interp_level = zetemp
        onelevel = -99999.

    if nocall:     pass
    else:          api.api_main ( path_to_input, input_name, path_to_output, output_name, \
                   process, fields, debug, bit64, oldvar, interp_level, \
                   interp_method, extrapolate, unstagger_grid, onelevel )

    return output_name
