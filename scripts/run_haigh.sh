#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=0
#SBATCH --partition=epyc
#SBATCH --mail-user=smerlak@mis.mpg.de
#SBATCH --mail-type=ALL

julia haigh-WF-extinction-times.jl > haigh-WF-extinction-times.log
julia haigh-agents-extinction-times.jl > haigh-agents-extinction-times.log