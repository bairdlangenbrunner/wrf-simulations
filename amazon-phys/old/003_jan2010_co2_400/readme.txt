Nothing worked trying to force with constant fields (need to ask question online)

Instead, just download .sh script to grab grib2 files
export RDAPSWD=Snopoop1

takes a while to do ungrib.exe
ungrib took about 50 minutes to do 30 days of 6hourly data, so that's ABOUT 2 minutes per day... plan accordingly...


then metgrid.exe

THEN change phys and time periods in namelist.input
then change pco2 to 400ppm for these runs

then run wrf.exe

ln -s stuff into WRFV3/run

in WRFV3/phys, change pco2 to 400ppm to start
THEN run real.exe
and THEN run wrf.exe


-bash-4.1$ ls *clm*
clmtypeinitmod.mod  clm_varcon.mod  clm_varsur.mod   module_sf_clm.f90  module_sf_clm.o
clmtype.mod         clm_varpar.mod  module_sf_clm.F  module_sf_clm.mod

-bash-4.1$ grep pco2 *clm*
module_sf_clm.F:  real(r8), parameter :: pco2   = 355.e-06     !constant atmospheric partial pressure CO2 (mol/mol)
module_sf_clm.F:  real(r8), pointer :: forc_pco2(:)    !CO2 partial pressure (Pa)
module_sf_clm.F:  allocate(a2l%forc_pco2(beg:end))
module_sf_clm.F:  a2l%forc_pco2(beg:end) = ival
module_sf_clm.F:  deallocate(a2l%forc_pco2)
module_sf_clm.F:! forc_pco2 and forc_po2. Keeping the same hardwired values as in CLM2 to
module_sf_clm.F:   real(r8), pointer :: forc_pco2(:)   ! partial pressure co2 (Pa)
module_sf_clm.F:   forc_pco2      => clm_a2l%forc_pco2
module_sf_clm.F:      co2(p) = forc_pco2(g)
module_sf_clm.F:  use clm_varcon  , only : rair, cpair, po2, pco2, tcrit,tfrz,pstd,sb
module_sf_clm.F:          clm_a2l%forc_pco2(g) = pco2 * clm_a2l%forc_pbot(g)
module_sf_clm.f90:  real(r8), parameter :: pco2 = 355.e-06
module_sf_clm.f90:  real(r8), pointer :: forc_pco2(:)
module_sf_clm.f90:  allocate(a2l%forc_pco2(beg:end))
module_sf_clm.f90:  a2l%forc_pco2(beg:end) = ival
module_sf_clm.f90:  deallocate(a2l%forc_pco2)
module_sf_clm.f90:   real(r8), pointer :: forc_pco2(:)
module_sf_clm.f90:   forc_pco2 => clm_a2l%forc_pco2
module_sf_clm.f90:      co2(p) = forc_pco2(g)
module_sf_clm.f90:  use clm_varcon , only : rair, cpair, po2, pco2, tcrit,tfrz,pstd,sb
module_sf_clm.f90:          clm_a2l%forc_pco2(g) = pco2 * clm_a2l%forc_pbot(g)


NEED TO CHANGE PCO2 IN module_sf_clm.F and module_sf_clm.f90