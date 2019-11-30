#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aliyar.ozercan@uconn.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=3:00:00    
#SBATCH -e error_%A_%a.log    
#SBATCH -o output_%A_%a.log
#SBATCH --partition=serial
##### END OF JOB DEFINITION  #####
unset LD_PRELOAD

module load singularity
singularity run \
--bind /scratch/psyc5171/$USER/group_feat:/input \
--bind /scratch/psyc5171/$USER/group_feat/derivatives/level2:/output \
/scratch/psyc5171/containers/hcpbids_4.0.sif \
/input/scripts/flame.sh
