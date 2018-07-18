Trying to keep the WRF configure/compile the same

And using a static data set (january averages, perhaps)

--let's just use a static 6 hour period to begin, and test it that way

need to:
in WPS
remove all files linked

run geogrid


in &metgrid
constants_name = 'SST:2006-04-01_00’

constants_name = 'FILE:

by the time you're done with WPS directory, you should have
GRIBFILE.AAA stuff
all the .exe's
run ./geogrid.exe
run ./ungrib.exe
change namelist to have constant file  (FILE:2012-06-01_00)
NOTE THE BEGINNING AND END DATE NEED TO MATCH THE SINGLE CONSTANT FILE...
run ./metgrib.exe



&metgrid
 constants_name = 'FILE:2012-06-01_00',
 io_form_metgrid = 2,
/

NOTE GOTTA GET RID OF TIME VARYING STUFF (fg_name)


ALSO ON THE namelist.input FILE, YOU MUST SPECIFY START AND END DATE TO BE THE EXACT SAME
and just change the number of hours that you run...

then real.exe will work

DIDN'T WORK

now trying to change time_interval to 172800 seconds (48*60*60)

didn't work

now deleted days, hours, minutes, seconds
left 172800
made end date 48 hours later