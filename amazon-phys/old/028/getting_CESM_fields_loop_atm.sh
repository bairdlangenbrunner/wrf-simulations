#cesm1_0_6.1850_4xco2_fdbgb.1deg.002  cesm1_0_6.1850_4xco2_fulgb.1deg.002
#cesm1_0_6.1850_4xco2_fixgb.1deg.001  cesm1_0_6.1850_prei.1deg.001

#case_name=cesm1_0_6.1850_4xco2_fdbgb.1deg.002
#case_name=cesm1_0_6.1850_4xco2_fixgb.1deg.001
#case_name=cesm1_0_6.1850_4xco2_fulgb.1deg.002
case_name=cesm1_0_6.1850_prei.1deg.001

data_type=atm

search_dir=/beegfs/DATA/pritchard/blangenb/GABE_RUNS/cesm1_0_6.1850_4xco2_fdbgb.1deg.002/arc/$data_type/hist

save_dir=/beegfs/DATA/pritchard/blangenb/CESM_PROCESSED/GABE_RUNS/$case_name/$data_type

VAR_ARRAY=(PRECT QFLX Q TS TMQ TREFHT U V)

for VAR in "${VAR_ARRAY[@]}"
do
  save_dir_with_var=$save_dir/$VAR
  mkdir $save_dir_with_var
  for entry in $search_dir/*h0*
  do
    entry_short=${entry#*hist/} # lop off prefix
    entry_short=${entry_short%.nc} # lop off suffic
    echo $entry_short
    new_entry="${save_dir_with_var}/${entry_short}_${VAR}.nc"
    ncks -O -v $VAR $entry $new_entry
    echo $new_entry
  done
done

data_type=lnd

search_dir=/beegfs/DATA/pritchard/blangenb/GABE_RUNS/cesm1_0_6.1850_4xco2_fdbgb.1deg.002/arc/$data_type/hist

save_dir=/beegfs/DATA/pritchard/blangenb/CESM_PROCESSED/GABE_RUNS/$case_name/$data_type

VAR_ARRAY=(H2OSOI QSOIL QVEGE QVEGT)

for VAR in "${VAR_ARRAY[@]}"
do
  save_dir_with_var=$save_dir/$VAR
  mkdir $save_dir_with_var
  for entry in $search_dir/*h0*
  do
    entry_short=${entry#*hist/} # lop off prefix
    entry_short=${entry_short%.nc} # lop off suffic
    echo $entry_short
    new_entry="${save_dir_with_var}/${entry_short}_${VAR}.nc"
    ncks -O -v $VAR $entry $new_entry
    echo $new_entry
  done
done