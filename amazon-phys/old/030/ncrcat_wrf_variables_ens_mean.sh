VAR_ARRAY=(QFX LH RAINC RAINNC ECAN EDIR ETRAN SH2O TSK T2)
DIR_LIST=(ens_calculations_001_010)

working_dir=$PWD
save_dir=${working_dir}/concat_nc_files

for DIR in "${DIR_LIST[@]}"
do
  file_dir=${working_dir}/${DIR}

  for VAR in "${VAR_ARRAY[@]}"
  do

	file_array=(${file_dir}/wrfout*${VAR}*.nc)

	start_file=${file_array[0]}
	end_file=${file_array[${#file_array[@]}-1]}

	start_file_time=${start_file%_$VAR*}
	start_file_time=${start_file_time#*d01_}

	end_file_time=${end_file%_$VAR*}
	end_file_time=${end_file_time#*d01_}

	out_file="wrfout_d01_${start_file_time}_${end_file_time}_${VAR}_ens_mean.nc"

	ncrcat ${file_array[@]} ${save_dir}/${out_file}
	echo $out_file
	
  done
done