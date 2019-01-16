# Maui Simulation Setup for IT4Innovations
This repository contains the setup of the Maui Scheduler to simulate the job scheduling of IT4Innovations' large-scale PBS based Salomon cluster. It has been used in our paper **Job Simulation for large-scale PBS based Clusters with the Maui Scheduler** (see section [Paper and Citation](#paper-and-citation) below) and is made available to enable other PBS based computing centers to run simulations. The following files are available:
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
\
You can get a preview (static only) using the Jupyter nbviewer:\
[<img src="https://nbviewer.jupyter.org/static/img/nav_logo.svg" width="150" alt="Preview in Jupyter nbviewer">](https://nbviewer.jupyter.org/github/It4innovations/Maui-Simulation/blob/master/interactive_plots/plots.ipynb)\
\
**Note**:\
To avoid incompatibility, please use the same Jupyter notebook environment we have used for creating the pickle files (uses Matplotlib 2.2.x). You can use the Jupyter notebook *scipy-notebook* (tag: 265297f221de) from [Docker Hub](https://hub.docker.com/r/jupyter/scipy-notebook/). In the subfolder `interactive_plots` of our repository, execute the following command:\
`$ docker run --rm -p 8888:8888 -v "$PWD":/home/jovyan/interactive_plots jupyter/scipy-notebook:265297f221de`\
Once prompted, open the printed URL in the browser. Open the Jupyter notebook file mentioned above and execute the notebook cell for interactive plots.\
\
Example of an interactive plot:\
![Alt text](images/interactive_plot_example.png?raw=true "Example of an interactive plot (cluster utilization of week 7)")

# Paper and Citation
The paper is available for download on [iadis digital library](http://www.iadisportal.org/digital-library/job-simulation-for-large-scale-pbs-based-clusters-with-the-maui-scheduler).

    @CONFERENCE{Zitzlsberger2018137,
        author={Zitzlsberger, G. and Jansík, B. and Martinovič, J.},
        title={Job simulation for large-scale PBS based clusters with the Maui Scheduler},
        journal={MCCSIS 2018 - Multi Conference on Computer Science and Information Systems; Proceedings of the International Conferences on Big Data Analytics, Data Mining and Computational Intelligence 2018, Theory and Practice in Modern Computing 2018 and Connected Smart Cities 2018},
        year={2018},
        pages={137-145}
    }

The extended version of the paper, published by the journal [IADIS INTERNATIONAL JOURNAL ON COMPUTER SCIENCE AND INFORMATION SYSTEMS](http://www.iadisportal.org/ijcsis/) Vol.13 Number 2 (2018), is available for download on [iadis digital library](http://www.iadisportal.org/ijcsis/papers/2018130204.pdf).

# Contact
Should you have any feedback or questions, please contact the author: Georg Zitzlsberger (georg.zitzlsberger(a)vsb.cz).

# Acknowledgement
This work was supported by The Ministry of Education, Youth and Sports from the Large Infrastructures for Research, Experimental
Development and Innovations project ”IT4Innovations National Supercomputing Center – LM2015070”, by the ERDF in the IT4Innovations national supercomputing center – path to exascale project (CZ.02.1.01/0.0/0.0/16_013/0001791) within the OPRDE, and ANTAREX, a project supported by the EU H2020 FET-HPC program under grant agreement No. 671623.

# License
This project is made available under the BSD 2-Clause License.
