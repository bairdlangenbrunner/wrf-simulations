#!/bin/bash

### Project name
#PBS -A UCIR0013

### Job name
#PBS -N geogrid

### Wallclock time
#PBS -l walltime=00:30:00

### Queue
#PBS -q regular

### Merge output and error files
#PBS -j oe

### Select 2 nodes with 36 CPUs, for 72 MPI processes
#PBS -l select=4:ncpus=36:mpiprocs=36

#PBS -M blangenb@uci.edu


mpiexec_mpt ./geogrid.exe




WORKED...

qsub -I -l select=4:ncpus=36:mpiprocs=36 -l walltime=02:00:00 -q regular -A UCIR0013



## !/bin/bash
## export JOB_NAME=geogrid
## 
## PBS -N ${JOB_NAME}
## PBS -A PUCIR0013
## PBS -l walltime=06:00:00
## PBS -q regular
## PBS -o output.${JOB_NAME}
## PBS -e errors.${JOB_NAME}
## PBS -m abe
## PBS -M blangenb@uci.edu
## PBS -l select=4:ncpus=36:mpiprocs=36
## 
## Load MPI I used to compile WRF
## module load openmpi/2.0.2
## 
## Assign TMPDIR to my scratch
## export TMPDIR=/glade/scratch/${USER}/tmp
## 
## Run WRF with OpenMPI
## mpiexec_mpt ./geogrid.exe