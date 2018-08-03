# Maui Simulation Setup for IT4Innovations
This repository contains the setup of the Maui Scheduler to simulate the job scheduling of IT4Innovations' large-scale PBS based Salomon cluster. It has been used in our paper [Job Simulation for large-scale PBS based Clusters with the Maui Scheduler](https://not_public_yet) and is made available to enable other PBS based computing centers to run simulations. The following files are available:
- `Dockerfile`: To create a Docker image with the Maui Scheduler environment. It includes PBS for satisfying the dependencies only, which does not need to run as a service.
- `maui.diff`: Modifications applied to the Maui Scheduler for our simulation runs.
- `maui.cfg`: Configuration file for the Maui Scheduler.
- `Resource.Trace1`: Trace file for Salomon cluster resources.
- `Workload.Trace_example`: Workload trace file (example only).
- `control_example.sh`: Control script for the simulation (example only).

> **Note**: No real workloads are made available due to privacy reasons.

# Quick Start Guide

1. Build the Docker image:\
Change the user name (replace `userx`) and paths in `maui.cfg` and `Dockerfile` to reflect your environment. Then, build the Docker image:\
`$ docker build -t maui_simulator .`

2. Start the Docker container:\
`$ docker run --rm -it --hostname mauisim -v .:/home/userx/workdir maui_simulator`\
Change the path `/home/userx/workdir` according to the previous changes.

3. Start simulation:\
Within the Docker container, start the Maui Scheduler's simulator:\
`/usr/local/maui/sbin/maui &`\
Then, execute the control script `control_example.sh`. Alternatively you can manually use the Maui Scheduler tools to control the simulation (`showstats`, `schedctl`, `setres`, etc.).\
The results can be found in the `stats` directory (file `simstat.out`).

# Interactive Plots
You can find the plots from the paper as a Jupyter notebook file (`interactive_plots/plots.ipynb`). It loads the plots from Python pickle files (`*.pkl`). Open the file in your own Jupyter notebook environment for interactive display.\
Example of an interactive plot:\
![Alt text](images/interactive_plot_example.png?raw=true "Example of an interactive plot (cluster utilization of week 7)")

# Acknowledgement
This work was supported by The Ministry of Education, Youth and Sports from the Large Infrastructures for Research, Experimental Development and Innovations project ”IT4Innovations National Supercomputing Center – LM2015070”, as well as by the ERDF in the IT4Innovations national supercomputing center - path to exascale project (CZ.02.1.01/0.0/0.0/16_013/0001791) within the OPRDE.
