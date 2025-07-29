#!/bin/bash
#SBATCH --nodes=1               #Numero de Nós
#SBATCH --ntasks-per-node=1     #Numero de tarefas por Nó
#SBATCH --ntasks=1             #Numero total de tarefas MPI
#SBATCH -p gdl      #Fila (partition) a ser utilizada
#SBATCH -J test_environment_creation          #Nome job
#SBATCH --gres=gpu:1
#SBATCH --time=00:30:00
#SBATCH --chdir=/prj/ideeps/daniel.mendes2  # Set working directory for SLURM
#SBATCH --output=/prj/ideeps/daniel.mendes2/jobs_outs/gpu_mem_check_%j.out 
#SBATCH --error=/prj/ideeps/daniel.mendes2/jobs_outs/gpu_mem_check_%j.err

echo "=========================================="
echo "Starting environment creation pipeline"
echo "Job ID: $SLURM_JOB_ID"
echo "=========================================="

#Exibe os nós alocados para o Job
echo "Step 1: Displaying allocated nodes..."
echo "Allocated nodes: $SLURM_JOB_NODELIST"
nodeset -e $SLURM_JOB_NODELIST

echo "Step 2: Changing to submit directory..."
cd $SLURM_SUBMIT_DIR
echo "Current directory: $(pwd)"

echo "Step 3: Loading MPI module..."
#Carregar um dos módulos do MPI instalados no cluster
module load openmpi/gnu/4.1.4_sequana
echo "MPI module loaded successfully"

echo "Step 3: Loading anaconda module..."
#Carregar um dos módulos do anaconda instalados no cluster
module load anaconda3/2024.02_sequana
echo "Anaconda module loaded successfully"

echo "Step 4: Creating conda environment..."
#Cria o ambiente virtual do python
conda create --prefix $SCRATCH/conda-env/test python=3.12.8 -y
echo "Conda environment created at: $SCRATCH/conda-env/test"

echo "Step 5: Activating conda environment..."
#Ativar o ambiente virtual do python
source activate $SCRATCH/conda-env/test
echo "Environment activated. Current conda env: $CONDA_DEFAULT_ENV"

echo "Step 6: Fixing linker issue..."
#Remover o executável 'ld' e criar link simbólico
rm $SCRATCH/conda-env/test/compiler_compat/ld
ln -s /usr/bin/ld $SCRATCH/conda-env/test/compiler_compat/ld
echo "Linker fixed successfully"

echo "Step 7: Installing MPI4PY..."
#Instalar o MPI4PY
pip install mpi4py
echo "MPI4PY installed successfully"

echo "Step 7: Installing tqdm..."
#Instalar o tqdm
pip install mpi4py
echo "tqdm installed successfully"

echo "Step 7: Installing Seaborn..."
#Instalar o Seaborn
pip install seaborn
echo "Seaborn installed successfully"

echo "Step 7: Installing IPython..."
#Instalar o IPython
pip install IPython
echo "IPython installed successfully"

echo "Step 8: Installing CuPy and NCCL..."
#Instalar Cupy e NCCL
conda install -c conda-forge cupy cudnn cutensor nccl -y
echo "CuPy and NCCL installed successfully"

echo "Step 10: Running turbulence simulation..."
mpiexec -n 1 python /prj/ideeps/daniel.mendes2/Sync/3D_turbulence_Multi_GPU_NCCL.py

echo "=========================================="
echo "Pipeline completed!"
echo "=========================================="