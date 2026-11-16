# AI Agent Handover: Milestone 1 - GitOps Automated Pipeline (Jenkins)

## 1. Project Context
We are duplicating a CI/CD testing framework for O-RAN O-Cloud environments, based on the thesis of Yosafat Marselino Agus (NTUST). The ultimate goal is to deploy a gNB on O-Cloud platforms via the O2 interface. 

The thesis explicitly uses **Jenkins** for the GitOps automated pipeline. Therefore, we must strictly use Jenkins. Do not use GitHub Actions or any other CI/CD tool. 

This document focuses strictly on **Milestone 1**.

## 2. Environment Constraints (CRITICAL)
*   **Host OS:** Windows 10.
*   **Virtualization:** WSL 2 with Ubuntu installed on Drive D.
*   **Container Engine:** Docker Engine is installed *inside* WSL 2 Ubuntu.
*   **Hardware Limit:** The host laptop has 16GB RAM. **DO NOT** attempt to install Kubernetes, StarlingX, or OKD yet. 
*   **Source Code:** The actual gNB source code is not yet available. We will use a **Dummy Application** (Nginx) to simulate the build process.

## 3. Milestone 1 Objectives
1.  Create a dummy application to simulate the gNB software.
2.  Set up Jenkins (running via Docker in WSL 2 Ubuntu).
3.  Create a `Jenkinsfile` that automatically builds the dummy application into a Docker image.
4.  Configure Jenkins to push the built image to an Image Registry (GitHub Container Registry / GHCR).
5.  Success Criteria: A `git push` to the repository automatically triggers Jenkins to build and push the image to GHCR without manual intervention.

## 4. Tech Stack
*   **Version Control:** Git & GitHub
*   **CI/CD Tool:** Jenkins (Dockerized inside WSL 2)
*   **Registry:** GitHub Container Registry (GHCR)
*   **Containerization:** Docker

## 5. Tasks for the AI Agent

### Task 1: Generate the Dummy Application
Create a simple web application that can be containerized.
*   Create `index.html` with a simple "Hello from Dummy gNB" message.
*   Create a `Dockerfile` using `nginx:alpine` as the base image. Copy the `index.html` to the Nginx HTML directory.

### Task 2: Create the Jenkins Pipeline (`Jenkinsfile`)
Create a declarative `Jenkinsfile` at the root of the project. The pipeline must have these stages:
*   **Checkout:** Pull the code from Git.
*   **Build:** Run `docker build -t ghcr.io/[GITHUB_USERNAME]/dummy-gnb:latest .`
*   **Push:** Login to GHCR using Jenkins credentials and push the image.
*   *(Note: The AI must write the exact Groovy syntax for the Jenkinsfile, utilizing `withCredentials` for the GHCR token).*

### Task 3: Setup Instructions for Jenkins (WSL 2 Environment)
Provide a step-by-step markdown guide (`SETUP_GUIDE.md`) on how to:
1.  Run Jenkins inside WSL 2 using Docker (the exact `docker run` command, ensuring it mounts the Docker socket `/var/run/docker.sock` so Jenkins can run Docker commands).
2.  Access Jenkins UI from Windows 10 browser via `localhost:8080`.
3.  Install the necessary Jenkins plugins (Git, Docker Pipeline, GitHub).
4.  Add the GitHub Personal Access Token (PAT) as a Jenkins Credential (Secret Text) for GHCR authentication.
5.  Create a new Pipeline job in Jenkins, point it to the GitHub repository.
6.  Explain how to trigger it automatically (e.g., using the "Poll SCM" feature in Jenkins as a simpler alternative to setting up GitHub Webhooks with ngrok).

## 6. Output Format Expected from AI Agent
Generate the actual file contents (`index.html`, `Dockerfile`, `Jenkinsfile`) and a `SETUP_GUIDE.md`.