#VAR_ARRAY=(ECAN EDIR ETRAN OH QFX RAINC RAINNC SH2O T2 TSK)   # 2d list
VAR_ARRAY=(QVAPOR T U V W)   # 3d list

FIELD_TYPE=3d_fields

DIR_LIST=(001 002 003 004 005 006 007 008 009 010)

working_dir=$PWD
save_dir=${working_dir}/concat_nc_files/${FIELD_TYPE}

cd ${save_dir}

for VAR in "${VAR_ARRAY[@]}"
do
  echo ${VAR}
  
  file_array=()
  for DIR in "${DIR_LIST[@]}"
  do
  	file_array+=" "wrfout_d01_2010-01-01_00:00:00_2010-01-11_00:00:00_${VAR}_${DIR}.nc
  done
  
  #echo "${file_array[@]}"
  out_file="wrfout_d01_ens_mean_001_010_${VAR}.nc"

  ncea -v ${VAR} ${file_array[@]} ${out_file}
  
  echo ${out_file}

done