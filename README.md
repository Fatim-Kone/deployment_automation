# **Open RAN DU Deployment Framework (Kubernetes & Helm)**

## Overview
This repository contains the deployment and automation framework used in my BSc thesis:

**“System-Level Analysis of Hardware Offloading in High-Performance Open RAN Deployments”**
It provides a reproducible, Kubernetes-based environment for deploying and evaluating multi-Distributed Unit (DU) Open RAN scenarios using the srsRAN Project, supporting both software-only and hardware-offloaded (Intel ACC100) configurations.
The framework enables systematic experimentation across a wide range of RAN and system parameters including DU scaling, concurrency, PRBs, MCS, SMT configurations, and real UE traffic.

## Features
-Kubernetes-based multi-DU deployment
-Helm charts for scalable and configurable experiments
-Automated experiment automation using YAML configurations
-Helm templates for configurable parameters such as srsRAN configuration file, PRBs, MCS, decoder iterations and Upper PHY concurrency
-Automated measurement scripts

## Repository Structure
- concurrencychart/       # Helm chart for concurrency experiments
- e2echart/               # End-to-end deployment chart
- prbchart/               # PRB scaling deployment chart
- smtcompetechart/        # SMT competing cores deployment chart
- smtpairedchart/         # SMT paired cores deployment chart
- tracechart/             # Trace CQI pattern deployment chart
- nochart/                # Minimal / baseline logging deployment chart
- oldchart/               # per-function-call logging deployment chart
- mychart/  # Load testing deployment chart
- createyaml_scripts/     # Scripts to generate experiment YAML files
- measurement_scripts/    # Scripts for collecting performance metrics for each experiment
- yamlConcurrencyFiles/   # YAML configs for concurrency experiments
- yamlDecoderIterationFiles/ # LDPC Decoder iteration configs
- yamlE2EFiles/           # End-to-end experiment configs
- yamlLoadTestingFiles/   # Load testing configs
- yamlMCSFiles/           # MCS variation configs
- yamlPRBFiles/           # PRB scaling configs
- yamlSMTCompeteFiles/    # SMT competing configs
- yamlSMTPairedFiles/     # SMT paired configs
- yamlTraceCQIFiles/      # CQI trace-based configs
- yamlNoLogsFiles/        # Runs without logging (baseline overhead)
- yamlOldLogsFiles/       # per-function-call logging method logging configs
