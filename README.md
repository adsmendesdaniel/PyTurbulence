# PyTurbulence: Multi-GPU Accelerated DNS Turbulence Simulator in Python

**PyTurbulence** is a Python-based framework for high-resolution simulations of three-dimensional homogeneous isotropic turbulence (HIT) using the spectral Galerkin method. The implementation supports GPU acceleration and parallelization across multiple GPUs using `mpi4py`, CuPy, and NCCL, making it suitable for both small-scale tests and large-scale simulations on supercomputers.

The codebase is organized around Jupyter notebooks and is compatible with free platforms such as Google Colab and Kaggle. It also scales seamlessly without modification to HPC systems like the Santos Dumont supercomputer.

> This repository is currently under active development.

---

## Main Features

- Single- and multi-GPU parallelization using `mpi4py`, CuPy, and NCCL.
- Notebook-based workflow compatible with Google Colab and Kaggle.
- Easily portable to HPC systems (e.g., SDumont) with minimal configuration.
- Modular and adaptable code for turbulence diagnostics and visualization.
