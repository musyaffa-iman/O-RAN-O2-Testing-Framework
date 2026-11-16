# Milestone 1 Setup Guide: Jenkins in WSL 2 & GitOps Pipeline

This guide outlines the steps to run Jenkins inside WSL 2 (Ubuntu) with Docker, configure authentication for GitHub Container Registry (GHCR), set up automated webhooks, and execute the CI pipeline.

---

## 1. Prerequisites Verification in WSL 2

Open your WSL 2 terminal (Ubuntu) and confirm Docker is installed and running:

```bash
docker --version
docker ps
```

If the Docker daemon is stopped, start it:
```bash
sudo service docker start
```

---

## 2. Launching Jenkins with Docker in WSL 2

To allow Jenkins to build Docker images, Jenkins needs access to the host's Docker daemon. We run Jenkins and bind mount the Docker Unix socket `/var/run/docker.sock`.

### Option A: Quick Run with Docker CLI Installed

1. Create a persistent volume for Jenkins data:
```bash
docker volume create jenkins_home
```

2. Run the Jenkins container with Docker socket and CLI access:
```bash
docker run -d \
  --name jenkins \
  --restart unless-stopped \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -u root \
  jenkins/jenkins:lts
```

3. Install the Docker client binary inside the running container so Jenkins pipeline commands (`docker build`, `docker push`) function:
```bash
docker exec -u root jenkins bash -c "curl -fsSL https://get.docker.com | sh"
```

4. Retrieve the initial admin password:
```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

---

## 3. Jenkins Initial Web Configuration

1. Open your Windows browser and navigate to:
   ```
   http://localhost:8080
   ```
2. Paste the initial admin password from step 2.
3. Select **Install suggested plugins**.
4. Create an admin user account and complete the setup wizard.
5. Go to **Manage Jenkins** -> **Plugins** -> **Available plugins** and ensure the following are installed:
   - **Docker Pipeline**
   - **GitHub Integration Plugin**
   - **Git Plugin** (installed by default)

Restart Jenkins if prompted.

---

## 4. Setting up GitHub Container Registry (GHCR) Credentials

1. Go to GitHub -> **Settings** -> **Developer settings** -> **Personal access tokens** -> **Tokens (classic)**.
2. Generate a new token with:
   - `write:packages`
   - `read:packages`
   - `delete:packages` (optional)
   - `repo`
3. In Jenkins, go to **Manage Jenkins** -> **Credentials** -> **System** -> **Global credentials (unrestricted)** -> **Add Credentials**.
4. Configure:
   - **Kind:** `Username with password`
   - **Username:** Your GitHub username (e.g. `musyaffa-iman`)
   - **Password:** The Personal Access Token (PAT) generated above
   - **ID:** `ghcr-credentials` (matches the `Jenkinsfile` setting)
   - **Description:** `GHCR Authentication Token`
5. Click **Create**.

---

## 5. Creating and Configuring the Jenkins Pipeline Job

1. From the Jenkins Dashboard, click **New Item**.
2. Enter item name (e.g., `dummy-gnb-pipeline`), select **Pipeline**, and click **OK**.
3. Under **Build Triggers**, check:
   - `GitHub hook trigger for GITScm polling`
4. Under the **Pipeline** section:
   - **Definition:** `Pipeline script from SCM`
   - **SCM:** `Git`
   - **Repository URL:** `https://github.com/musyaffa-iman/O-RAN-O2-Testing-Framework.git`
   - **Branch Specifier:** `*/main`
   - **Script Path:** `Jenkinsfile`
5. Click **Save**.

---

## 6. Setting up GitHub Webhook (via ngrok)

Because Jenkins is running locally inside WSL 2, GitHub cannot reach `localhost:8080` directly without a public tunnel.

1. Start an ngrok tunnel in WSL or Windows:
   ```bash
   ngrok http 8080
   ```
2. Copy the forwarded HTTPS URL (e.g. `https://xxxx-xx-xx.ngrok-free.app`).
3. In your GitHub repository:
   - Go to **Settings** -> **Webhooks** -> **Add webhook**.
   - **Payload URL:** `https://<your-ngrok-url>/github-webhook/` *(ensure trailing slash is present)*
   - **Content type:** `application/json`
   - **Which events:** `Just the push event`
   - Click **Add webhook**.

---

## 7. Testing the Automated Pipeline

1. Make a small edit or commit in the repository:
   ```bash
   git add .
   git commit -m "feat: trigger automated build for dummy-gnb"
   git push origin main
   ```
2. Observe Jenkins automatically triggering the build.
3. Once completed, verify the published container image on GitHub:
   `https://github.com/musyaffa-iman?tab=packages`

---

## 8. Fallback: GitHub Actions Native CI

If local memory usage in WSL 2 is constrained, the native GitHub Actions workflow in [deploy.yml](file:///.github/workflows/deploy.yml) provides an identical build and push process without running Jenkins locally. It runs automatically upon each push to `main`.
