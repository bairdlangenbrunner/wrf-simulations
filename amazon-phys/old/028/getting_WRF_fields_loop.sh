#ncks -v QFX wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_QFX.nc
#ncks -v LH wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_LH.nc
#ncks -v T2 wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_T2.nc
#ncks -v U10 wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_U10.nc
#ncks -v V10 wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_V10.nc
#
##ncks -v T wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_T.nc
##ncks -v U wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_U.nc
##ncks -v V wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_V.nc
##ncks -v W wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_W.nc
##ncks -v QVAPOR wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_QVAPOR.nc
#
#ncks -v RAINC wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_RAINC.nc
#ncks -v RAINNC wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_RAINNC.nc
#ncks -v Times wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_Times.nc
#ncks -v XLAT wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_XLAT.nc
#ncks -v XLONG wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_XLONG.nc
#ncks -v HGT wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_HGT.nc
#ncks -v LANDMASK wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_LANDMASK.nc
#
#ncks -v ECAN wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_ECAN.nc
#ncks -v EDIR wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_EDIR.nc
#ncks -v ETRAN wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_ETRAN.nc
#
#ncks -v SMOIS wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_SMOIS.nc
#ncks -v SH2O wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_SH2O.nc
#
#ncks -v TSK wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_TSK.nc

#ncks -v LU_INDEX wrfout_d01_2010-01-01_00:00:00 wrfout_d01_2010-01-01_00:00:00_LU_INDEX

# FOR EACH VARIABLE in list of variables
# mk variable directory
# create list of files
# get time stamp of those files
# loop through those files and pull out that variable, rename file, save into variable directory

export search_dir=.

#VAR_ARRAY=(QFX LH RAINC RAINNC Times XLAT XLONG LANDMASK ECAN EDIR ETRAN SH2O LU_INDEX)
VAR_ARRAY=(LH RAINC RAINNC Times XLAT XLONG LANDMASK ECAN EDIR ETRAN SH2O LU_INDEX)
for VAR in "${VAR_ARRAY[@]}"
do
  mkdir $VAR
  for entry in $search_dir/wrfout*
  do
    entry_short=${entry#./}
    echo $entry_short
    new_entry="${VAR}/${entry_short}_${VAR}.nc"
    ncks -v $VAR $entry_short $new_entry
    echo $new_entry
  done
done

#VAR_ARRAY=(QFX LH RAINC RAINNC Times XLAT XLONG LANDMASK ECAN EDIR ETRAN SH2O LU_INDEX)
#for VAR in "${VAR_ARRAY[@]}"; do echo $VAR; done
# 
# for entry in $search_dir/*
# do
#   entry_short=${entry#./}
#   echo $entry_short
#   new_entry="./${VAR}/${entry_short}_${VAR}.nc"
#   echo $new_entry
# done
 # removes everything after first dot:  "${entry%.*}"
 

# https://stackoverflow.com/questions/125281/how-do-i-remove-the-file-suffix-and-path-portion-from-a-path-string-in-bash


# for entry in "$search_dir"/*
# do
#   echo "$entry"
# done