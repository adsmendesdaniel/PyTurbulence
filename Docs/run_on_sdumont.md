# SDumont Cluster: Available Nodes for the project (IDEEPS)

## List Your Associations

```bash
sacctmgr -P show associations user=$USER format=Account,Partition
```

---

## Sdumont 1: GPU Partitions

| Account | Partition           | Timelimit | Nodes | GPU  | GPUs/Node | Memory/GPU | Notes/Issues         |
|---------|---------------------|-----------|-------|------|-----------|------------|----------------------|
| ideeps  | gdl                 | infinite  | 1     | v100 | 8         |            | Running forever      |
| ideeps  | sequana_gpu_dev     | infinite  | 61    | v100 | 4         |            | See error *          |
| ideeps  | sequana_gpu_shared  | infinite  | ?     | ?    | ?         |            | See error **         |
| ideeps  | sequana_gpu         | infinite  | 53    | v100 | 4         |            | See error ***        |
| ideeps  | sequana_gpu_long    | infinite  | 51    | v100 | 8         |            | See error ****       |

### Common SLURM Errors

#### * sequana_gpu_dev, sequana_gpu, sequana_gpu_long

```text
sbatch: error: AssocMaxSubmitJobLimit
sbatch: error: Batch job submission failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)
```
- **Solution:** Check your job limits with `squeue -u $USER` and cancel jobs if needed. Contact support for higher limits.

#### ** sequana_gpu_shared

```text
sbatch: error: invalid partition specified: sequana_gpu_shared
sbatch: error: Batch job submission failed: Invalid partition name specified
```
- **Solution:** Verify partition name with `sinfo` or your account associations.

#### ***** sequana_gpu_shared

```bash
sinfo -p sequana_gpu_shared -o "%n %G %t"
HOSTNAMES GRES STATE
```
- **Note:** No nodes may be available or partition may not exist.

---

## Example SLURM Script

```bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH -p sequana_gpu_long
#SBATCH -J check_gpu_01
#SBATCH --time=00:01:00
#SBATCH --output=gpu_mem_check_%j.out

echo "Running on partition: $SLURM_JOB_PARTITION"
echo "Node: $HOSTNAME"
echo ""

nvidia-smi
```

---

## Sdumont 2: Other Partitions

| Account | Partition           | Timelimit | Nodes | GPU     | GPUs/Node | Memory/GPU    | Notes/Issues |
|---------|---------------------|-----------|-------|---------|-----------|--------------|--------------|
| ideeps  | lncc-gh200          | unlimited | 16    | Null    | ?         | ?            |              |
| ideeps  | lncc-gh200_dev      | 00:20:00  | 32    | (S:0-3) | 4         | 120gb (GH200) |              |
| ideeps  | lncc-gh200_shared   | unlimited | 30    | ?       | 2         | 120gb (GH200) |              |
| ideeps  | lncc-grace          | unlimited | 8     | Null    | ?         | *            | See error *  |
| ideeps  | lncc-h100_dev       | 00:20:00  | 52    | (S:0-3) | 4         | 80gb (H100)   |              |
| ideeps  | lncc-h100_shared    | unlimited | 50    | (S:0-1) | 4         | 80gb (H100)   |              |
| ideeps  | lncc-mi300a         | unlimited | 10    | Null    | 8         | ??           | See error *  |
| ideeps  | lncc-mi300a_dev     | unlimited | 16    | (S:0-1) | 2         | ?            | See error ** |
| ideeps  | lncc-mi300a_shared  | 00:20:00  | 14    | (S:0-1) | 2         | ?            | See error ** |

### Common SLURM Errors

#### * Requested node configuration is not available

```text
sbatch: error: Batch job submission failed: Requested node configuration is not available
```
- **Solution:** Check available nodes and resources with `sinfo`. Adjust your job request.

#### ** nvidia-smi not found

```text
/var/spool/slurmd/job42201/slurm_script: line 15: nvidia-smi: command not found
```
- **Solution:** Make sure you are requesting a GPU node. If the node does not have NVIDIA GPUs, `nvidia-smi` will not be available.

---

## Tips

- Use `squeue -u $USER` to check your jobs.
- Use `sinfo` to check available partitions and nodes.
- Contact cluster support for persistent issues