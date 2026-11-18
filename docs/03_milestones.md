# Project Milestones

The goal is to duplicate the framework described in the thesis. The milestones are structured to build the system incrementally, moving from basic automation to complex observability.

## Milestone 1: GitOps Automated Pipeline (Ref: Thesis 3.2)
**Goal:** Automate the build and deployment trigger.
- [x] Set up a Git repository as the single source of truth.
- [x] Configure Jenkins to monitor the repository for changes.
- [x] Create a build script to compile O-RAN software (gNB/DU) and package it into a container image.
- [x] Push the container image to an Image Registry.
- [x] *Success Criteria:* A git commit automatically triggers a successful image build and push.

*Status Note (Date): Completed local setup. Tested using a dummy Nginx application to verify the webhook and build trigger. Ready to swap with actual O-RAN source code once provided.

## Milestone 2: O2 Interface Abstraction (Ref: Thesis 3.3 & 2.2.2)
**Goal:** Build the NFO and FOCOM modules to abstract O-Cloud platform differences.
- [ ] **FOCOM (IMS):** Develop a REST API endpoint (`GET /cloud/resource`) to query CPU, memory, and hardware accelerator availability from the O-Cloud.
- [ ] **NFO (DMS):** Develop REST API endpoints (`POST /vnf/create` and `POST /vnf/terminate`) to handle VNF lifecycle management.
- [ ] Implement translation logic to convert standardized requests into platform-specific manifests (Kubernetes for OKD, Helm for StarlingX).
- [ ] *Success Criteria:* The APIs can successfully query resources and deploy a dummy pod on a test cluster.

## Milestone 3: rApp Test Orchestrator (Ref: Thesis 3.3)
**Goal:** Create the state machine that orchestrates the entire test lifecycle.
- [ ] Develop a logic engine (e.g., using Python) that parses test requests.
- [ ] Implement the workflow: Query Resource -> Deploy VNF -> Activate Profiler -> Generate Traffic -> Collect Results -> Cleanup.
- [ ] Integrate the rApp with the NFO and FOCOM modules built in Milestone 2.
- [ ] *Success Criteria:* A single command can run the entire test sequence without manual intervention.

## Milestone 4: Sideload Profiler (Ref: Thesis 3.4)
**Goal:** Build the deep observability tool for containerized RAN.
- [ ] Develop a lightweight profiling container.
- [ ] Configure the container to share the host's PID namespace.
- [ ] Implement data collection for CPU isolation, DPDK thread pinning, and Hugepage usage.
- [ ] Expose the aggregated metrics via a standardized HTTP API.
- [ ] *Success Criteria:* The profiler successfully exposes thread-to-core affinity and CPU utilization metrics.

## Milestone 5: Integration and AWS Adaptation (Ref: Thesis 4 & Prof. Cheng's Direction)
**Goal:** Execute the full end-to-end test matrix and explore deployment on public cloud.
- [ ] Execute the 24 test configurations (Platform x Vendor x CPU allocation x Bandwidth).
- [ ] Analyze the stability results and bottleneck patterns.
- [ ] **Exploration:** Adapt the deployment logic to run the gNB on top of AWS (as suggested by Prof. Cheng), evaluating the differences in timing constraints and observability challenges in a public cloud environment compared to on-premise StarlingX.