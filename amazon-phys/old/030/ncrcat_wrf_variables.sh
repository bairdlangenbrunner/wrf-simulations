VAR_ARRAY=(QFX LH RAINC RAINNC Times ECAN EDIR ETRAN SH2O TSK T2)
DIR_LIST=(001 002 003 004 005 006 007 008 009 010)

#case_name=030.co2_400.idealized.50km.noahmp.1hr.stoch.ensemble
case_name=031.co2_1000.idealized.50km.noahmp.1hr.stoch.ensemble

working_dir=/beegfs/DATA/pritchard/blangenb/WRF_ARCHIVE/${case_name}
save_dir=/beegfs/DATA/pritchard/blangenb/WRF_ARCHIVE/${case_name}/concat_nc_files

file_array=(wrfout*)

start_file=${file_array[0]}
end_file=${file_array[${#file_array[@]}-1]}

for DIR in "${DIR_LIST[@]}"
do

  for VAR in "${VAR_ARRAY[@]}"
  do

	cd ${working_dir}/${DIR}/${VAR}
	file_array=(wrfout*)

	start_file=${file_array[0]}
	end_file=${file_array[${#file_array[@]}-1]}

	start_file_time=${start_file%_$VAR*}
	start_file_time=${start_file_time#*d01_}

	end_file_time=${end_file%_$VAR*}
	end_file_time=${end_file_time#*d01_}


	out_file="wrfout_d01_${start_file_time}_${end_file_time}_${VAR}_${DIR}.nc"

	ncrcat ${file_array[@]} ${save_dir}/${out_file}
	echo $out_file

  done
done