#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --job-name=20210922_vast_align_combine
#SBATCH --output=20210922_vast_align_combine_output.txt
#SBATCH --mail-user=hasna.khan@mail.utoronto.ca
#SBATCH --mail-type=ALL

export PATH=/scratch/n/nprovart/khanha55/vast-tools:$PATH #using scratch path here since home is read-only and align will write to vast-out
export PATH=/home/n/nprovart/khanha55/bowtie-1.3.1-linux-x86_64:$PATH

module load NiaEnv/2019b #added this and the next 2 lines for attempt 2, after attempt 1 failed for lack of python (??)
module load intel/2019u4
module load python/3.8.5
module load perl/5.34.0
module load gcc/9.2.0
module load r/4.0.3

cd $SLURM_SUBMIT_DIR

for file in /scratch/n/nprovart/khanha55/rawseqdata/*.gz; do
vast-tools align $file -sp araTha10 --expr --IR_version 2 --dbDir /scratch/n/nprovart/khanha55/vast-tools -c 80
done

vast-tools combine -sp araTha10 -o vast_out --dbDir /scratch/n/nprovart/khanha55/vast-tools