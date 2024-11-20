---
title: "SLURM monitoring"
layout: default
nav_order: 5
---

Last update: 20241120

# Monitoring jobs and node configurations on slurm

Slurm schedules jobs in a fair and orderly manner, taking into account various factors to optimize the use of available resources. If all nodes are fully occupied with long-running jobs, it may not be possible to expedite the scheduling of new jobs. However, such situations are relatively rare, as Slurm's scheduling algorithms are designed to maximize efficiency and minimize wait times. This ensures that all users get fair access to the resources in a timely manner.

To effectively manage and monitor jobs on a Slurm cluster, it's important to know a few basic commands that provide insights into job status, queue details, and node configurations. Here are two essential commands:

## Commands

- **`squeue`**: This command displays information about jobs queued and running.
- **`sinfo`**: This command shows the status of the partitions and nodes in the cluster.

## Understanding `squeue` uutput

The following table explains the output columns of the `squeue` command:

| Column       | Description                                        |
|--------------|----------------------------------------------------|
| JOBID        | Unique identifier for each job                     |
| PARTITION    | The partition (queue) the job is running on        |
| NAME         | The name of the job                                |
| USER         | The username of the job owner                      |
| ST           | The state of the job (R for running, PD for pending)|
| TIME         | The time the job has been running or waiting       |
| NODES        | The number of nodes being used                     |
| NODELIST(REASON) | The specific nodes being used or the reason if pending |

## Example `squeue` output

```plaintext
JOBID PARTITION     NAME     USER    ST    TIME  NODES NODELIST(REASON)
98467 all-nodes   dbnsfp username1  R     7:23     1 tenant-name-slurm-compute-dynamic-13
98458 dynamic-8 sys/dash username1  R  3:06:49     1 tenant-name-slurm-compute-dynamic-01
98464 dynamic-8 sys/dash username2 PD     0:00     1 (Resources)
98460 dynamic-8 sys/dash username2  R  2:18:27     1 tenant-name-slurm-compute-dynamic-04
```

## Understanding `sinfo` output

The following table explains the output columns of the `sinfo` command:

| Column    | Description                                                              |
|-----------|--------------------------------------------------------------------------|
| PARTITION | Name of the partition.                                                   |
| AVAIL     | Availability of the partition (`up` for available, `inact` for inactive).|
| TIMELIMIT | Maximum time that jobs can run in this partition (usually `infinite`).   |
| NODES     | Number of nodes available or in use in the partition.                    |
| STATE     | Current state of the nodes:                                              |
|           | - `alloc`: All of the nodes are allocated to jobs.                       |
|           | - `idle~`: Nodes are idle with possibly some jobs pending.               |
|           | - `down`: Nodes are down and not available for jobs.                     |
|           | - `mix`: Nodes are partially allocated, some resources are free.         |
| NODELIST  | Specific nodes assigned to the partition.                                |


## Example `sinfo` Output

```plaintext
PARTITION                           AVAIL  TIMELIMIT  NODES  STATE NODELIST
static                              inact   infinite      1   down tenant-name-slurm-compute-template
dynamic-8cores-16g*                    up   infinite      4  alloc tenant-name-slurm-compute-dynamic-[01-04]
dynamic-16cores-32g                    up   infinite      4  idle~ tenant-name-slurm-compute-dynamic-[05-08]
dynamic-16cores-64g                    up   infinite      4  idle~ tenant-name-slurm-compute-dynamic-[09-12]
dynamic-16cores-128g                   up   infinite      1  idle~ tenant-name-slurm-compute-dynamic-14
dynamic-16cores-128g                   up   infinite      1    mix tenant-name-slurm-compute-dynamic-13
dynamic-a100gpu-128cores-900g-4gpus    up   infinite      1  idle~ tenant-name-slurm-compute-dynamic-gpu-01
all-nodes-cpu                          up   infinite      9  idle~ tenant-name-slurm-compute-dynamic-[05-12,14]
all-nodes-cpu                          up   infinite      1    mix tenant-name-slurm-compute-dynamic-13
all-nodes-cpu                          up   infinite      4  alloc tenant-name-slurm-compute-dynamic-[01-04]
```

By regularly using `squeue` and `sinfo`, users can manage their jobs more effectively and plan their resource usage according to the availability and current load of the compute cluster.


## Note on resource requests in slurm

{: .note }

When submitting jobs to Slurm, it is crucial to ensure that your resource requests match what is actually available on the system. Requesting resources that exceed the system's capabilities, such as asking for 500GB of memory on a node that offers significantly less, may lead to your job hanging indefinitely without launching or providing any failure notices. To avoid these issues, please use the sinfo command regularly to verify the available resources and configurations on the cluster. This careful checking can help ensure that your job submissions are compatible with the system's capabilities, preventing unnecessary delays.


