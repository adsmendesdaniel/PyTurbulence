# Available nodes for the project (IDeeps):

got with the command: sacctmgr -P show associations user=$USER format=Account,Partition

## Sdumont 1

Account|Partition          |Timelimit | Nodes | GPU  | How many | Memory/GPU | Problem
ideeps |gdl                |infinite  | 1     | v100 | 8        |            | Running forever
ideeps |sequana_gpu_dev    |infinite  | 61    | v100 | 4        |            | *
ideeps |sequana_gpu_shared |infinite  | ?     | *****           |            | **
ideeps |sequana_gpu        |infinite  | 53    | v100 | 4        |            | ***
ideeps |sequana_gpu_long   |infinite  | 51    | v100 | 8        |            | ****

*
(base) [daniel.mendes2@sdumont17 sbatch_files]$ sbatch check_gpu_memory_on_a_specific_partition.sbatch 
sbatch: error: AssocMaxSubmitJobLimit
sbatch: error: Batch job submission failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)

**
(base) [daniel.mendes2@sdumont17 sbatch_files]$ sbatch check_gpu_memory_on_a_specific_partition.sbatch 
sbatch: error: invalid partition specified: sequana_gpu_shared
sbatch: error: Batch job submission failed: Invalid partition name specified

***
(base) [daniel.mendes2@sdumont17 sbatch_files]$ sbatch check_gpu_memory_on_a_specific_partition.sbatch 
sbatch: error: AssocMaxSubmitJobLimit
sbatch: error: Batch job submission failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)

****
(base) [daniel.mendes2@sdumont17 sbatch_files]$ sbatch check_gpu_memory_on_a_specific_partition.sbatch 
sbatch: error: AssocMaxSubmitJobLimit
sbatch: error: Batch job submission failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)

*****
(base) [daniel.mendes2@sdumont17 sbatch_files]$ sinfo -p sequana_gpu_shared -o "%n %G %t"
HOSTNAMES GRES STATE

#.sbatch
#!/bin/bash
#SBATCH --nodes=1               #Numero de Nós
#SBATCH --ntasks-per-node=1     #Numero de tarefas por Nó
#SBATCH --ntasks=1             #Numero total de tarefas MPI
#SBATCH -p sequana_gpu_long      #Fila (partition) a ser utilizada
#SBATCH -J check_gpu_01          #Nome job
#SBATCH --time=00:01:00
#SBATCH --output=gpu_mem_check_%j.out  #Save a file with the output

echo "Running on partition: $SLURM_JOB_PARTITION"
echo "Node: $HOSTNAME"
echo ""

nvidia-smi


## Sdumont 2

Account|Partition          |Timelimit | Nodes | GPU     | How many | Memory/GPU    | Problem
ideeps |lncc-gh200         |unlimited | 16    | Null    | ?        | ?             | 
ideeps |lncc-gh200_dev     |00:20:00  | 32    | (S:0-3) | 4        | 120gb (GH200) |
ideeps |lncc-gh200_shared  |unlimited | 30    | ?       | 2        | 120gb (GH200) |
ideeps |lncc-grace         |unlimited | 8     | Null    | ?        | *             | *
ideeps |lncc-h100_dev      |00:20:00  | 52    | (S:0-3) | 4        | 80gb (H100)   |
ideeps |lncc-h100_shared   |unlimited | 50    | (S:0-1) | 4        | 80gb (H100)   |
ideeps |lncc-mi300a        |unlimited | 10    | Null    | 8        | ??            | *
ideeps |lncc-mi300a_dev    |unlimited | 16    | (S:0-1) | 2        | ?             | **
ideeps |lncc-mi300a_shared |00:20:00  | 14    | (S:0-1) | 2        | ?             | **

*(/scratch/ideeps/daniel.mendes2/pyturbulence-env/mpi4py) [daniel.mendes2@sdumont2nd5 sbatch_scripts]$ sbatch check_gpu_memory_of_a_node.slurm 
sbatch: error: Batch job submission failed: Requested node configuration is not available

**/var/spool/slurmd/job42201/slurm_script: line 15: nvidia-smi: command not found
