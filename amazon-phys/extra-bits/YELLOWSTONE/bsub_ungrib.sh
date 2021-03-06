#!/bin/bash
#
#BSUB -a poe                  # set parallel operating environment
#BSUB -P UCIR0013         # project code
#BSUB -J ungrib      # job name
#BSUB -W 06:00                # wall-clock time (hrs:mins)
#BSUB -B # email when job starts
#BUSB -N # email when job ends
#BSUB -n 256                   # number of tasks in job
#BSUB -R "span[ptile=16]"      # run four MPI tasks per node
#BSUB -q regular              # queue
#BSUB -e errors.ungrib     # error file name in which %J is replaced by the job ID
#BSUB -o output.ungrib     # output file name in which %J is replaced by the job ID

export OMP_NUM_THREADS=16
export MP_TASK_AFFINITY=cpu

mpirun.lsf ./ungrib.exe
exit
