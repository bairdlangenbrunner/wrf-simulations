#VAR_ARRAY=(QFX LH)
VAR_ARRAY=(RAINC RAINNC Times ECAN EDIR ETRAN SH2O)
#VAR_ARRAY=(U V W)

case_name=028.co2_400.idealized.50km.noahmp.1hr
working_dir=/beegfs/DATA/pritchard/blangenb/WRF_ARCHIVE/$case_name

file_array=(wrfout*)

start_file=${file_array[0]}
end_file=${file_array[${#file_array[@]}-1]}

for VAR in "${VAR_ARRAY[@]}"
do
  cd $working_dir/$VAR
  file_array=(wrfout*)
  
  start_file=${file_array[0]}
  end_file=${file_array[${#file_array[@]}-1]}
  
  start_file_time=${start_file%_$VAR*}
  start_file_time=${start_file_time#*d01_}
  
  end_file_time=${end_file%_$VAR*}
  end_file_time=${end_file_time#*d01_}
  
  out_file="wrfout_d01_${start_file_time}_${end_file_time}_${VAR}.nc"
  
  ncrcat ${file_array[@]} $out_file
  echo $out_file
done