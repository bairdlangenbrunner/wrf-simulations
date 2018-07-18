#!/bin/bash
#
#BSUB -a poe                  # set parallel operating environment
#BSUB -P P35681102         # project code
#BSUB -J compile      # job name
#BSUB -W 00:30                # wall-clock time (hrs:mins)
#BSUB -n 128                   # number of tasks in job
#BSUB -R "span[ptile=16]"      # run four MPI tasks per node
#BSUB -q regular              # queue
#BSUB -e errors.compile     # error file name in which %J is replaced by the job ID
#BSUB -o output.compile     # output file name in which %J is replaced by the job ID

export OMP_NUM_THREADS=16
export MP_TASK_AFFINITY=cpu

mpirun.lsf ./compile em_real >& log.compile
exit
