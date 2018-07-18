#!/bin/bash
#
#PBS -N job_name
#PBS -A UCIR0013
#PBS -l walltime=01:00:00
#PBS -q queue_name
#PBS -j oe
#PBS -m abe
#PBS -M your_email_address
#PBS -l select=16:ncpus=36:mpiprocs=36

# Load MPI I used to compile WRF
#module load openmpi/2.0.2

# Assign TMPDIR to my scratch
export TMPDIR=/glade/scratch/${USER}/tmp

# Run WRF with OpenMPI
mpirun -n 256 ./ungrib.exe
# 
# 
# 
# 
# 
# 
# 
# 
# ### Set TMPDIR as recommended
# mkdir -p /glade/scratch/username/temp
# export TMPDIR=/glade/scratch/username/temp
# 
# ### Run the executable
# mpiexec_mpt dplace -s 1 ./executable_name.exe
# 
# 
# #BSUB -a poe                  # set parallel operating environment
# #BSUB -P UCIR0013         # project code
# #BSUB -J ungrib      # job name
# #BSUB -W 06:00                # wall-clock time (hrs:mins)
# #BSUB -B # email when job starts
# #BUSB -N # email when job ends
# #BSUB -n 256                   # number of tasks in job
# #BSUB -R "span[ptile=16]"      # run four MPI tasks per node
# #BSUB -q regular              # queue
# #BSUB -e errors.ungrib     # error file name in which %J is replaced by the job ID
# #BSUB -o output.ungrib     # output file name in which %J is replaced by the job ID
# 
# export OMP_NUM_THREADS=16
# export MP_TASK_AFFINITY=cpu
# 
# mpirun.lsf ./ungrib.exe
# exit
