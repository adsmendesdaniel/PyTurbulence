#!/bin/bash
#SBATCH --nodes=16                            #Numero de Nós
#SBATCH --ntasks-per-node=1                   #Numero de tarefas por Nó
#SBATCH --ntasks=16                           #Numero total de tarefas MPI
#SBATCH --cpus-per-task=1                     #CPUs per task
#SBATCH -p lncc-h100_dev                      #Fila (partition) a ser utilizada
#SBATCH -J test_h100_running                  #Nome job
#SBATCH --gpus-per-node=1                     #Request GPUs
#SBATCH --time=00:20:00
#SBATCH --mem=32G                             #Memory per node
#SBATCH --chdir=/prj/ideeps/daniel.mendes2  # Set working directory for SLURM
#SBATCH --output=/prj/ideeps/daniel.mendes2/jobs_outs/h100_test_%j.out 
#SBATCH --error=/prj/ideeps/daniel.mendes2/jobs_outs/h100_test_%j.err

echo "=========================================="
echo "Starting environment pipeline"
echo "Job ID: $SLURM_JOB_ID"
echo "=========================================="

#Exibe os nós alocados para o Job
echo "Step 1: Displaying allocated nodes..."
echo "Allocated nodes: $SLURM_JOB_NODELIST"
nodeset -e $SLURM_JOB_NODELIST

echo "Step 2: Changing to submit directory..."
cd $SLURM_SUBMIT_DIR
echo "Current directory: $(pwd)"

echo "Step 4: Loading MPI module..."
#Carregar um dos módulos do MPI instalados no cluster
module load openmpi/4.1.6.15.1
echo "MPI module loaded successfully"

echo "Step 5: Loading anaconda module..."
#Carregar um dos módulos do anaconda instalados no cluster
module load anaconda3/2024.10
echo "Anaconda module loaded successfully"

echo "Step 6: Checking if conda environment exists..."
ENV_PATH="$SCRATCH/conda-env/mpi4py"

if [ -d "$ENV_PATH" ]; then
    echo "✓ Conda environment already exists at: $ENV_PATH"
    echo "Skipping environment creation pipeline..."

    echo "Step 6: Activating existing conda environment..."
    source activate $ENV_PATH
    echo "Environment activated. Current conda env: $CONDA_DEFAULT_ENV"
    
else
    echo "✗ Conda environment not found. Creating new environment..."
    
    echo "Step 7: Creating conda environment..."
    #Cria o ambiente virtual do python
    conda create --prefix $ENV_PATH python=3.12.8 -y
    echo "Conda environment created at: $ENV_PATH"

    echo "Step 8: Activating conda environment..."
    #Ativar o ambiente virtual do python
    source activate $ENV_PATH
    echo "Environment activated. Current conda env: $CONDA_DEFAULT_ENV"

    echo "Step 9: Fixing linker issue..."
    #Remover o executável 'ld' e criar link simbólico
    rm $ENV_PATH/compiler_compat/ld
    ln -s /usr/bin/ld $ENV_PATH/compiler_compat/ld
    echo "Linker fixed successfully"

    echo "Step 10: Installing MPI4PY..."
    #Instalar o MPI4PY
    pip install mpi4py
    echo "MPI4PY installed successfully"

    echo "Step 11: Installing tqdm..."
    #Instalar o tqdm
    pip install tqdm
    echo "tqdm installed successfully"

    echo "Step 12: Installing Seaborn..."
    #Instalar o Seaborn
    pip install seaborn
    echo "Seaborn installed successfully"

    echo "Step 13: Installing IPython..."
    #Instalar o IPython
    pip install IPython
    echo "IPython installed successfully"

    echo "Step 14: Installing CuPy and NCCL..."
    #Instalar Cupy e NCCL
    conda install -c conda-forge cupy cudnn cutensor nccl -y
    echo "CuPy and NCCL installed successfully"
    
    echo "Environment setup completed!"
fi

echo "Step FINAL: Running turbulence simulation..."
mpiexec -n 16 python /scratch/ideeps/daniel.mendes2/src/3D_turbulence_Multi_GPU_NCCL.py

echo "=========================================="
echo "Pipeline completed!"
echo "=========================================="