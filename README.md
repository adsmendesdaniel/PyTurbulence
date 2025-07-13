# PyTurbulence: Multi-GPU Accelerated DNS Turbulence Simulator in Python

**PyTurbulence** is a Python-based framework for high-resolution simulations of three-dimensional homogeneous isotropic turbulence (HIT) using the spectral Galerkin method. The implementation supports GPU acceleration and parallelization across multiple GPUs using `mpi4py`, CuPy, and NCCL, making it suitable for both small-scale tests and large-scale simulations on supercomputers.

The codebase is organized around Jupyter notebooks and is compatible with free platforms such as Google FColab and Kaggle. It also scales seamlessly without modification to HPC systems like the Santos Dumont supercomputer.

> This repository is currently under active development.

---

## Main Features

- Single- and multi-GPU parallelization using `mpi4py`, CuPy, and NCCL.
- Notebook-based workflow compatible with Google Colab and Kaggle.
- Easily portable to HPC systems (e.g., SDumont) with minimal configuration.
- Modular and adaptable code for turbulence diagnostics and visualization.

## Project Structure

```
PyTurbulence/
├── Data/                 # Raw and processed datasets
├── Data_analysis/        # Jupyter notebooks for data analysis and experiments
├── Docs/                 # Documentation and additional resources
├── Experimental/         # Experimental code and prototypes
├── External_projects/    # Projects and code from external repositories
├── Src/                  # Core source code for 3D and 2D simulations
├── experimental/         # Additional experimental scripts or code
├── README.md             # Project documentation
├── LICENSE               # License information
```