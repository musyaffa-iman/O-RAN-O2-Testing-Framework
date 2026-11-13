# O-RAN O2 Testing Framework Duplication

This repository contains my notes, architecture breakdown, and milestone plan for duplicating the automated CI/CD testing framework for O-RAN, based on the master's thesis of Yosafat Marselino Agus (NTUST, 2026).

## Project Objective
To replicate the platform-agnostic testing framework that deploys RAN software on O-Cloud (StarlingX and OKD) via the O-RAN O2 interface, orchestrates end-to-end testing, and profiles performance using a Sideload Profiler.

## Core Components to Duplicate
1. **GitOps Automated Pipeline:** Jenkins and Git to automate build and deployment.
2. **O2 Interface Abstraction:** Custom NFO (Network Function Orchestrator) and FOCOM (Federated O-Cloud Orchestration and Management) modules.
3. **rApp Test Orchestrator:** Logic to coordinate resource checking, VNF instantiation, and cleanup.
4. **Sideload Profiler:** A lightweight container sharing the host PID namespace to capture hardware and application-level metrics.

## Repository Structure
- `docs/01_architecture.md`: Notes on the SMO, O2 interface, and O-Cloud layers.
- `docs/02_tech_stack.md`: Tools and dependencies required.
- `docs/03_milestones.md`: The step-by-step execution plan.

## Current Status
Currently in the planning and milestone definition phase. Source code and design documents will be integrated upon receipt from the lab.