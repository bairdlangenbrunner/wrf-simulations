#!/bin/bash
export JOB_NAME=metgrid
#
#PBS -N ${JOB_NAME}
#PBS -A UCIR0013
#PBS -l walltime=06:00:00
#PBS -q regular
#PBS -o output.${JOB_NAME}
#PBS -e errors.${JOB_NAME}
#PBS -m abe
#PBS -M blangenb@uci.edu
#PBS -l select=4:ncpus=36:mpiprocs=36

# Load MPI I used to compile WRF
#module load openmpi/2.0.2

# Assign TMPDIR to my scratch
export TMPDIR=/glade/scratch/${USER}/tmp

# Run WRF with OpenMPI
mpirun -n 144 ./metgrid.exe