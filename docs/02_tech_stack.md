# Technology Stack & Environment Strategy

This document lists the tools required to duplicate the framework and outlines the strategy for development given local hardware constraints.

## 1. Software Stack
*   **CI/CD & Version Control:** Git, Jenkins, Container Image Registry.
*   **Cloud & Orchestration:** StarlingX (Target O-Cloud), OKD (Target O-Cloud), Kubernetes (Local Dev).
*   **RAN & Networking:** OAI gNB, DPDK, SR-IOV, PTP, Physical O-RUs (Pegatron/LiteOn).
*   **Observability:** Sideload Profiler (Custom).
*   **Languages (Expected):** Python or Go (for NFO/FOCOM), Bash (for automation scripts).

## 2. Hardware Environment Strategy (Phased Approach)

**Constraint:** My local development machine is limited to a 4-core CPU and 16GB of RAM. This is insufficient to run a full nested virtualization of StarlingX and OKD simultaneously alongside a development environment.

**Solution:** I will adopt a phased approach to ensure continuous progress without being blocked by hardware limitations.

### Phase A: Local Development (Lightweight)
*   **Goal:** Develop and test the logic for the NFO, FOCOM, and rApp orchestrator.
*   **Environment:** Use lightweight Kubernetes distributions like `kind` (Kubernetes in Docker) or `k3s` on the local laptop.
*   **Execution:** Mock the O2 IMS/DMS API endpoints. Use an RF simulator for the gNB instead of physical hardware. This proves the API orchestration logic works before touching a real O-Cloud.

### Phase B: Integration & Cloud Testing (Remote)
*   **Goal:** Deploy the full framework (including Sideload Profiler) on an actual O-Cloud platform.
*   **Environment:** I will request remote access to the NTUST lab servers for StarlingX testing. Alternatively, I will use an AWS EC2 instance (as suggested by Prof. Cheng) to test public cloud deployment constraints, which is the ultimate research goal.

---
*Note: The exact programming languages and frameworks used for the NFO and FOCOM modules will be updated once the source code is shared.*