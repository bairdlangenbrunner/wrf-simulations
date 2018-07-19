import numpy
import datetime
import os

season='FMAASO'
raw_data_dir='/glade/scratch/baird/NCEP2_MEAN_FILES/METGRID_FILES_RAW_OUTPUT/'+season
save_data_dir='/glade/scratch/baird/NCEP2_MEAN_FILES/METGRID_FILES_COPIED/'+season

timedelta_1979_days = (datetime.datetime(1979,6,1,0) - datetime.datetime(1979,1,1,0)).days
timedelta_list = [datetime.datetime(1979,1,1,0)+datetime.timedelta(hours=int(i)) for i in numpy.arange(0,24*timedelta_1979_days,6)]
filename_list = numpy.array(['met_em.d01.'+i.strftime('%Y-%m-%d_%H:%M:%S')+'.nc' for i in timedelta_list])

hour00 = numpy.array(['00:00:00' in i for i in filename_list])
hour06 = numpy.array(['06:00:00' in i for i in filename_list])
hour12 = numpy.array(['12:00:00' in i for i in filename_list])
hour18 = numpy.array(['18:00:00' in i for i in filename_list])

filenames00 = filename_list[hour00]
filenames06 = filename_list[hour06]
filenames12 = filename_list[hour12]
filenames18 = filename_list[hour18]

orig00 = raw_data_dir+'/met_em.d01.1979-01-01_00:00:00.nc'
orig06 = raw_data_dir+'/met_em.d01.1979-01-01_06:00:00.nc'
orig12 = raw_data_dir+'/met_em.d01.1979-01-01_12:00:00.nc'
orig18 = raw_data_dir+'/met_em.d01.1979-01-01_18:00:00.nc'

# https://sourceforge.net/p/nco/discussion/9830/thread/47678be1/
# help on ncap2
for i in range(filenames00.size):
	#print    ("ncap2 -O -s 'Times(:,:)="+'"'+filenames00[i].split('.')[2]+'"'+"' "+filenames00[i]+' '+filenames00[i])
	os.system('cp '+orig00+' '+save_data_dir+'/'+filenames00[i])
	os.system("ncap2 -O -s 'Times(:,:)="+'"'+filenames00[i].split('.')[2]+'"'+"' "+save_data_dir+'/'+filenames00[i]+' '+save_data_dir+'/'+filenames00[i])
for i in range(filenames06.size):
	os.system('cp '+orig06+' '+save_data_dir+'/'+filenames06[i])
	os.system("ncap2 -O -s 'Times(:,:)="+'"'+filenames06[i].split('.')[2]+'"'+"' "+save_data_dir+'/'+filenames06[i]+' '+save_data_dir+'/'+filenames06[i])
for i in range(filenames12.size):
	os.system('cp '+orig12+' '+save_data_dir+'/'+filenames12[i])
	os.system("ncap2 -O -s 'Times(:,:)="+'"'+filenames12[i].split('.')[2]+'"'+"' "+save_data_dir+'/'+filenames12[i]+' '+save_data_dir+'/'+filenames12[i])
for i in range(filenames18.size):
	os.system('cp '+orig18+' '+save_data_dir+'/'+filenames18[i])
	os.system("ncap2 -O -s 'Times(:,:)="+'"'+filenames18[i].split('.')[2]+'"'+"' "+save_data_dir+'/'+filenames18[i]+' '+save_data_dir+'/'+filenames18[i])

# orig00 = raw_data_dir+'/met_em.d01.1979-01-01_00:00:00.nc'
# orig06 = raw_data_dir+'/met_em.d01.1979-01-01_06:00:00.nc'
# orig12 = raw_data_dir+'/met_em.d01.1979-01-01_12:00:00.nc'
# orig18 = raw_data_dir+'/met_em.d01.1979-01-01_18:00:00.nc'
#
# for i in range(filenames00.size):
#     os.system('cp '+orig00+' '+filenames00[i])
#     os.system('ncatted -O -a data,Times,c,c,"'+filenames00[i].split('.')[2]+'" '+filenames00[i])
# for i in range(filenames06.size):
#     os.system('cp '+orig06+' '+filenames06[i])
#     os.system('ncatted -O -a data,Times,c,c,"'+filenames06[i].split('.')[2]+'" '+filenames06[i])
# for i in range(filenames12.size):
#     os.system('cp '+orig12+' '+filenames12[i])
#     os.system('ncatted -O -a data,Times,c,c,"'+filenames12[i].split('.')[2]+'" '+filenames12[i])
# for i in range(filenames18.size):
#     os.system('cp '+orig18+' '+filenames18[i])
#     os.system('ncatted -O -a data,Times,c,c,"'+filenames18[i].split('.')[2]+'" '+filenames18[i])
#     #print(filenames00[i])
