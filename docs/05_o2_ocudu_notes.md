# O2 Specification & OCUDU Study Notes

## 1. O-RAN O2 Interface
The O2 interface connects the SMO (Service Management and Orchestration) to the O-Cloud. It is divided into two main services:
- **O2 IMS (Infrastructure Management Service):** Manages the underlying cloud infrastructure (resource discovery, inventory, scaling). 
  - *Connection to Thesis:* This is what **FOCOM** implements.
- **O2 DMS (Deployment Management Service):** Manages the lifecycle of Network Functions (VNFs) running on the O-Cloud (deployment, termination, healing).
  - *Connection to Thesis:* This is what **NFO** implements.

## 2. OCUDU (Open Centralized Unit Distributed Unit)
OCUDU is an open-source project combining O-CU and O-DU. Key takeaways from the background material:
- **CU/DU Split:** The O-CU (handles non-real-time tasks like RRC/PDCP) and O-DU (handles real-time L1/L2 tasks) communicate via the **F1 interface**.
- **Near-RT RIC Integration:** The Near-RT RIC connects to the O-CU/DU via the **E2 interface** to deploy xApps for real-time control.
- **Fronthaul:** The O-DU connects to the O-RU via the **Open Fronthaul 7.2 split**.
- *Insight:* Deploying a gNB on AWS (Prof. Cheng's suggestion) will require careful consideration of how the F1 and E2 interfaces behave over a public cloud network compared to a local lab.

### 3. OCUDU Retina Framework: Evolution for Multi-Vendor Integration

**Source:** [Evolving the OCUDU Retina Framework for End-to-End, Multi-Vendor Integration Testing](https://youtu.be/uvtx9Yd22cg) (OCUDU Ecosystem Foundation, Nov 2026)

**Current Limitation:**
The existing Retina testing framework is tightly coupled to internal processes. This restricts its ability to orchestrate external components, such as diverse 5G Core implementations or physical O-RU hardware from different vendors.

**Proposed Architectural Shift:**
The presentation (a collaboration between UNH Interoperability Labs and Wind River) proposes a move toward a **modular, "building-block" approach**. The key idea is to **decouple the deployment of RAN components (CU/DU, Core, O-RU) from the test automation harness itself**.

**Key Enabler: Ansible-Driven Orchestration**
Instead of hardcoding the deployment steps into the test framework, the new approach uses **Ansible** to manage diverse deployment stacks. This allows the same test scenarios to be shared between component-level testing and end-to-end testing, regardless of the underlying infrastructure.

**Relevance to Yosafat's Thesis & My Work:**
- **Shared Philosophy:** Both Yosafat's framework (using NFO/FOCOM via O2) and the Retina evolution aim to abstract infrastructure differences to enable vendor-neutral testing.
- **Ansible vs. O2:** While Yosafat uses the O-RAN standard O2 interface for deployment, the Retina framework leverages Ansible. This is a valuable comparison point: O2 is telecom-grade and standardized, while Ansible is a general-purpose IT automation tool.
- **Future Consideration:** For deploying a gNB on AWS (Milestone 5), an Ansible-driven approach could be a lightweight alternative or complement to building a full O2 interface abstraction.