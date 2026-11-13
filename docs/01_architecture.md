# System Architecture Breakdown

Based on Chapter 2 of Yosafat's thesis, the framework is divided into three primary layers to achieve platform-agnostic testing.

## 1. Service Management and Orchestration (SMO) Layer
This is the central command center. It hosts the automation logic.
*   **GitOps rApp Orchestrator:** The "brain" that monitors Git repositories, triggers builds, and coordinates the test lifecycle.
*   **Service Management Engine (SME):** Exposes SMO services to external networks.
*   **Data Management Engine (DME):** Stores test results and performance metrics.

## 2. O2 Interface Abstraction Layer
This layer bridges the SMO and the O-Cloud, hiding the complexity of different cloud platforms.
*   **FOCOM (Federated O-Cloud Orchestration and Management):** Implements the O2 IMS (Infrastructure Management Service). It handles resource discovery (CPU, memory, SR-IOV) and inventory management across different clouds.
*   **NFO (Network Function Orchestrator):** Implements the O2 DMS (Deployment Management Service). It translates deployment requests into platform-specific manifests (e.g., Kubernetes YAML for OKD, Helm charts for StarlingX) and manages the VNF lifecycle.

## 3. O-Cloud Infrastructure Layer
The physical and virtualized environment hosting the RAN functions.
*   **Platforms:** StarlingX (OpenStack-based) and OKD (Kubernetes-based).
*   **Workloads:** Containerized O-RAN Network Functions (O-CU, O-DU).
*   **Sideload Profiler:** A sidecar container sharing the host PID namespace to collect deep metrics (DPDK threads, Hugepages, CPU isolation) and expose them via an HTTP API.
*   **Hardware:** COTS servers (Dell R750) with SR-IOV NICs, connected to physical O-RUs (Pegatron, LiteOn) via a Fronthaul Gateway.