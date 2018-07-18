import netCDF4
import numpy
import datetime
import glob
import matplotlib.pyplot as mp
import os


working_dir = '/beegfs/DATA/pritchard/blangenb/REANALYSIS_DATA/NCEP2'
save_dir = '/beegfs/DATA/pritchard/blangenb/REANALYSIS_DATA/NCEP2_PROCESSED_ANNUAL_MEAN_TIME_AXIS'

variables_list = numpy.array(( \
'TT', \
'RH', \
'UU', \
'VV', \
'GHT', \
'PSFC', \
'PMSL', \
'SKINTEMP_gauss', \
'TT_2m_gauss', \
'SPECHUMD_2m_gauss', \
'UU_10m_gauss', \
'VV_10m_gauss', \
'SM000010_gauss', \
'SM010200_gauss', \
'ST000010_gauss', \
'ST010200_gauss' ))

variables_ncfile = numpy.array(( \
'air', \
'rhum', \
'uwnd', \
'vwnd', \
'hgt', \
'pres', \
'mslp', \
'skt', \
'air', \
'shum', \
'uwnd', \
'vwnd', \
'soilw', \
'soilw', \
'tmp', \
'tmp' ))

variables_out_ncfile = numpy.array(( \
'TT', \
'RH', \
'UU', \
'VV', \
'GHT', \
'PSFC', \
'PMSL', \
'SKINTEMP', \
'TT', \
'SPECHUMD', \
'UU', \
'VV', \
'SM000010', \
'SM010200', \
'ST000010', \
'ST010200' ))

var_dict = {}
for i in range(variables_list.size):
	var_dict[variables_list[i]] = variables_ncfile[i]

remove_attrs = ['_FillValue','missing_value','unpacked_valid_range','actual_range','valid_range','add_offset','scale_factor']

season_type = 'FMAASO'
months_list = [2,3,4,8,9,10]

for var_idx in range(variables_list.size):
	var = variables_list[var_idx]
	print('working on '+var)

	var_dir = working_dir + '/' + var
	file_list = numpy.array(( sorted(glob.glob(var_dir + '/' + '*.nc')) ))

	# works for variables with a time axis!
	var_shape = netCDF4.Dataset(file_list[0], 'r', 'NetCDF4').variables[variables_ncfile[var_idx]].shape
	var_original = netCDF4.Dataset(file_list[0], 'r', 'NetCDF4').variables[variables_ncfile[var_idx]]

	#cf=mp.contourf(var_original[0,:,:])
	#mp.colorbar(cf)
	#mp.show()
	#exit()

	var_data_allyears_hour00 = numpy.zeros((file_list.size,) + var_shape[1:])*numpy.nan # eliminate time dimension
	var_data_allyears_hour06 = numpy.zeros((file_list.size,) + var_shape[1:])*numpy.nan
	var_data_allyears_hour12 = numpy.zeros((file_list.size,) + var_shape[1:])*numpy.nan
	var_data_allyears_hour18 = numpy.zeros((file_list.size,) + var_shape[1:])*numpy.nan

	for file_idx in range(file_list.size):
		print('<<<===>>> file '+file_list[file_idx])

		ncfile = netCDF4.Dataset(file_list[file_idx], 'r', 'NetCDF4')

		time_var = ncfile.variables['time']
		time = time_var[:]

		time_datetimes = netCDF4.num2date(time, time_var.units, calendar='standard')
		hour00_indices = [t.hour==0 and t.month in months_list for t in time_datetimes]
		hour06_indices = [t.hour==6 and t.month in months_list for t in time_datetimes]
		hour12_indices = [t.hour==12 and t.month in months_list for t in time_datetimes]
		hour18_indices = [t.hour==18 and t.month in months_list for t in time_datetimes]

		var_data_all = ncfile.variables[variables_ncfile[var_idx]]

		#var_data_all = var_data_all[:] * var_data_all.scale_factor + var_data_all.add_offset
		var_data_allyears_hour00[file_idx,::] = numpy.nanmean(var_data_all[hour00_indices,::],axis=0)
		var_data_allyears_hour06[file_idx,::] = numpy.nanmean(var_data_all[hour06_indices,::],axis=0)
		var_data_allyears_hour12[file_idx,::] = numpy.nanmean(var_data_all[hour12_indices,::],axis=0)
		var_data_allyears_hour18[file_idx,::] = numpy.nanmean(var_data_all[hour18_indices,::],axis=0)

	print('done with '+var)
	# once all files are done, take full mean
	var_data_mean_hour00 = numpy.nanmean(var_data_allyears_hour00, axis=0)
	var_data_mean_hour06 = numpy.nanmean(var_data_allyears_hour06, axis=0)
	var_data_mean_hour12 = numpy.nanmean(var_data_allyears_hour12, axis=0)
	var_data_mean_hour18 = numpy.nanmean(var_data_allyears_hour18, axis=0)

	var_data_mean_hour00[numpy.isnan(var_data_mean_hour00)]=-999
	var_data_mean_hour06[numpy.isnan(var_data_mean_hour06)]=-999
	var_data_mean_hour12[numpy.isnan(var_data_mean_hour12)]=-999
	var_data_mean_hour18[numpy.isnan(var_data_mean_hour18)]=-999

	# then add an extra time axis to each
	var_data_mean_hour00 = numpy.expand_dims(var_data_mean_hour00, axis=0)
	var_data_mean_hour06 = numpy.expand_dims(var_data_mean_hour06, axis=0)
	var_data_mean_hour12 = numpy.expand_dims(var_data_mean_hour12, axis=0)
	var_data_mean_hour18 = numpy.expand_dims(var_data_mean_hour18, axis=0)

	# create ncfile
	year_start = file_list[0].split('/')[-1].split('.')[-2]
	year_end = file_list[-1].split('/')[-1].split('.')[-2]

	file_out00 = save_dir +'/'+ variables_list[var_idx]+'_'+variables_ncfile[var_idx]+'_'+year_start+'-'+year_end+'_'+season_type+'_hour00.nc'
	file_out06 = save_dir +'/'+ variables_list[var_idx]+'_'+variables_ncfile[var_idx]+'_'+year_start+'-'+year_end+'_'+season_type+'_hour06.nc'
	file_out12 = save_dir +'/'+ variables_list[var_idx]+'_'+variables_ncfile[var_idx]+'_'+year_start+'-'+year_end+'_'+season_type+'_hour12.nc'
	file_out18 = save_dir +'/'+ variables_list[var_idx]+'_'+variables_ncfile[var_idx]+'_'+year_start+'-'+year_end+'_'+season_type+'_hour18.nc'

	if os.path.isfile(file_out00):  os.remove(file_out00)
	if os.path.isfile(file_out06):  os.remove(file_out06)
	if os.path.isfile(file_out12):  os.remove(file_out12)
	if os.path.isfile(file_out18):  os.remove(file_out18)

	file_data_list = [var_data_mean_hour00, var_data_mean_hour06, var_data_mean_hour12, var_data_mean_hour18]
	file_out_list = [file_out00, file_out06, file_out12, file_out18]; file_hour_list = [0,6,12,18]

	#cf=mp.contourf(file_data_list[0])
	#mp.colorbar(cf)
	#mp.show()
	#exit()

	for file_idx in range(len(file_out_list)):
		ncfile_out = netCDF4.Dataset(file_out_list[file_idx], 'w', 'NetCDF4')
		to_exclude = ['time_bnds',variables_ncfile[var_idx]]
		# global attribtes
		for name in ncfile.ncattrs():
			if name=='time':
				ncfile_out.setncattr(name, ncfile.getncattr(name))
			elif name not in to_exclude:
				ncfile_out.setncattr(name, ncfile.getncattr(name))
		# dimensions
		for name, dimension in ncfile.dimensions.items():
			if name=='time':
				ncfile_out.createDimension(name, None)
			elif name not in to_exclude:
				ncfile_out.createDimension(name, (len(dimension)))# if not dimension.isunlimited else None))
		# variables
		for name, variable in ncfile.variables.items():
			if name=='time':
				var_out = ncfile_out.createVariable(name, variable.datatype, variable.dimensions)
				ncfile_out.variables[name][:] = netCDF4.date2num(datetime.datetime(1979,1,1,file_hour_list[file_idx]), ncfile[name].units, calendar='standard')
				ncfile_out.variables[name].setncatts({key:variable.getncattr(key) for key in variable.ncattrs()})
			elif name not in to_exclude:
				var_out = ncfile_out.createVariable(name, variable.datatype, variable.dimensions)
				ncfile_out.variables[name][:] = ncfile.variables[name][:]
				ncfile_out.variables[name].setncatts({key:variable.getncattr(key) for key in variable.ncattrs()})

		# create the variable you have taken the mean for (skipped over using "toexclude")
		print(ncfile.variables[variables_ncfile[var_idx]].ncattrs())
		if 'missing_value' in ncfile.variables[variables_ncfile[var_idx]].ncattrs():
			ncfile_out.createVariable(variables_out_ncfile[var_idx], type(file_data_list[file_idx].flatten()[0]), ncfile.variables[variables_ncfile[var_idx]].dimensions[:], fill_value=-999)

			#fill_value=ncfile.variables[variables_ncfile[var_idx]].getncattr('missing_value'))

			print('_FillValue has been assigned to '+variables_out_ncfile[var_idx]+' as ' + '-999') #str(ncfile.variables[variables_ncfile[var_idx]].getncattr('missing_value')))
		else:
			ncfile_out.createVariable(variables_out_ncfile[var_idx], type(file_data_list[file_idx].flatten()[0]), ncfile.variables[variables_ncfile[var_idx]].dimensions[:], fill_value=None)

		ncfile_out.variables[variables_out_ncfile[var_idx]][:] = file_data_list[file_idx][:]
		var_attributes = var_original.ncattrs()
		for attr in remove_attrs:
			if attr in var_attributes:
				var_attributes.remove(attr)
		ncfile_out.variables[variables_out_ncfile[var_idx]].setncatts({key:var_original.getncattr(key) for key in var_attributes})
		print("saved "+file_out_list[file_idx])
