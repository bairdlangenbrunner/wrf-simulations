working_dir=$PWD
gauss_dir=${working_dir}/ncfiles_gauss
regrid_dir=${working_dir}/ncfiles_regrid

original_dir=/beegfs/DATA/pritchard/blangenb/REANALYSIS_DATA/NCEP2
destination_grid_file=${original_dir}/land_invertlat.nc

mask_grid_file=${original_dir}/mask.gauss.nc

FILE_ARRAY=(${gauss_dir}/SKINTEMP*gauss*.nc ${gauss_dir}/SPECHUMD*gauss*.nc ${gauss_dir}/TT*gauss*.nc ${gauss_dir}/UU*gauss*.nc ${gauss_dir}/VV*gauss*.nc)

SAVE_DIR=${regrid_dir}

for ((i=0;i<${#FILE_ARRAY[@]};i+=1))
do

  file_name=${FILE_ARRAY[$i]}
  file_name_no_ext=${file_name%.nc}
  file_name_stripped=${file_name_no_ext##*/}

  # regrid
  input_file=${FILE_ARRAY[i]}
  output_file=${SAVE_DIR}/"${file_name_stripped/gauss/regrid}".nc

  echo ${input_file}
  echo ${destination_grid_file}
  echo ${output_file}

  ncremap -i ${input_file} -d ${destination_grid_file} -o ${output_file}.tmp
  ncpdq -O -a -lat ${output_file}.tmp ${output_file}.tmp
  ncks -O -C -x -v slat,w_stag,slon,lat_bnds,lon_bnds,level_bnds,gw,area ${output_file}.tmp ${output_file}
  rm ${output_file}.tmp

done