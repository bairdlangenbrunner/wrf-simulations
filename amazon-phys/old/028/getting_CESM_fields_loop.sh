cesm1_0_6.1850_4xco2_fdbgb.1deg.002  cesm1_0_6.1850_4xco2_fulgb.1deg.002
cesm1_0_6.1850_4xco2_fixgb.1deg.001  cesm1_0_6.1850_prei.1deg.001

export search_dir=/beegfs/DATA/pritchard/blangenb/cesm1_0_6.1850_4xco2_fdbgb.1deg.002

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