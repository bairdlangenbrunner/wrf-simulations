**To run WRF in this idealized setup, you need to pre-process all forcing data.**

Do this in these steps:

1. Download NCEP2 reanalysis data for 1979-2015ish
  * The following variables are needed to force a WRF run (see the WRF user's guide, page 3-36, for a full table with options):

| field abbrev. | field full name | regridded? (i.e., downloaded on gaussian grid but regridded using NCO to cyl. equid.)
|-------|-------|-------|
|  TT |  3D air temperature (K) | -- |
| UU   | 3D zonal wind (m s<sup>-1</sup>)  | -- |
| VV   | 3D meridional wind (m s<sup>-1</sup>)  | -- |
| RH   | 3D relative humidity (%) | -- |
| GHT   |  3D geopotential height (m) | -- |
| PMSL   | mean sea-level pressure (Pa)  | -- |
| PSFC   | surface pressure (Pa)  | -- |
| SKINTEMP   |  skin temperature (K) | yes |
| TT 2m   | 2m air temperature | yes |
| SPECHUM 2m   | 2m specific humidity (kg kg<sup>-1</sup>)  | yes |
|  UU 10m  | 10m zonal wind (m s<sup>-1</sup>) | yes |
| VV 10m   | 10m meridional wind (m s<sup>-1</sup>)  | yes |
| SM000010   | soil moisture (0 to 10 cm) (m<sup>3</sup>m<sup>-3</sup>)  | yes |
| SM010200   | soil moisture (10 to 200 cm) (m<sup>3</sup>m<sup>-3</sup>  | yes |
| ST000010   | soil temperature (0 to 10 cm) (m<sup>3</sup>m<sup>-3</sup>  | yes |
| SM010200   |  soil temperature (10 to 200 cm) (m<sup>3</sup>m<sup>-3</sup> | yes |
| LANDSEA   | land-sea mask (water=0, land=1)  | --  |

2. Take FMAASO means on the native grids (some are on a gaussian grid)
  * These files will not have a time stamp associated with them
  * located on greenplanet at:  ```/beegfs/DATA/pritchard/blangenb/WRF_FORCING_DATA/NCEP2_PROCESSED_MEANS```
  * Means are taken using the ```create_ncep2_wrf_means_time_axis_FMAASO.py``` script in this directory.

3. Once the means are taken (6-hourly data 4x daily, so at hours 00, 06, 12, 18), regrid the files that are in a gaussian grid (the ones regridded for this project have a "yes" in the third column above).
  * To regrid files on a gaussian grid, you need a "mask" file (actually just a land mask, with land=1 and water=0 (like the LANDSEA variable in the table above))
    - Create this by taking the original ```land.sfc.gauss.nc``` file downloaded for NCEP2, and use the ```NCO``` command to rename the land variable to mask, and create a new file as output:  
```ncrename -v land,mask land.sfc.gauss.nc mask.gauss.nc```
  * Regridding is done using the ```regrid_ncep2_gauss_files.sh``` script in this directory.  The ```mask.gauss.nc``` file is included in the regridding process.

4. Then convert all ```.nc``` files into ```.grb``` (GRIB) files using ```CDO``` within the ```grib_file_creation_FMAASO.sh``` script.
  * Note the 2m, 10m, and soil moisture and temperature variables need attached ```.txt``` files in the ```cdo grb``` command (included in this directory).

5. Once these grib files are created, merge them using ```CDO``` (this command is at the bottom of the ```grib_file_creation_FMAASO.sh``` script).  For hour 06, this looks like:  
```cdo merge *hour06*.grb merged_input_hour06.grb```

6. Once these merged grib files are created, you can use these in the WRF preprocessing system (WPS).  The steps you take are:  
  1. run geogrid
  2. run ungrib
  3. run metgrid
  4. run wrf

**running geogrid**  
* depends on ```namelist.wps``` (lat/lon information, east/west extent, dx and dy)

**running ungrib**  
* depends on ```namelist.wps```
  * ```start_date```
  * ```end_date```
  * ```interval_seconds``` (seconds between output files)
* also requires a correct ```Vtable``` file; see ```Vtable_NCEP2_edited_for_idealized_forcing.txt``` in this directory
