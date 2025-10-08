# docker-flask-sample

[![Publish Docker image (GHCR)](https://img.shields.io/github/actions/workflow/status/Simar-DevOps/docker-flask-sample/publish-image.yml?label=Publish%20Docker%20image&logo=github-actions)](https://github.com/Simar-DevOps/docker-flask-sample/actions)
[![License](https://img.shields.io/badge/License-MIT-informational)](LICENSE)

Small Flask app packaged with Docker & served by Gunicorn. Health endpoint at `/healthz`.

## What’s here
- `Dockerfile` — non-root, UTF-8 fix, healthcheck
- `app.py` — Flask app with `/healthz`
- `k8s/` — Deployment + Service (tested on minikube)
- `.github/workflows/publish-image.yml` — builds & pushes to GHCR on tag

## Image (GitHub Container Registry)

images are multi-arch
**Current release:**
ghcr.io/simar-devops/docker-flask-sample:v0.1.4

Also available:
- `ghcr.io/simar-devops/docker-flask-sample:v0.1.3`
- `ghcr.io/simar-devops/docker-flask-sample:latest` (on default branch when tagged)

## Pull & Run (local)

```bash
docker pull ghcr.io/simar-devops/docker-flask-sample:v0.1.4
docker run --rm -p 8080:8000 ghcr.io/simar-devops/docker-flask-sample:v0.1.4
# open http://localhost:8080/healthz
Release Flow (CI → GHCR)
Commit code to main

Tag a release (semantic): vMAJOR.MINOR.PATCH (e.g., v0.1.5)

GitHub Actions builds & publishes to GHCR:

ghcr.io/simar-devops/docker-flask-sample:<tag>

ghcr.io/simar-devops/docker-flask-sample:<short-sha>

latest (when tagging the default branch)

Workflow file: .github/workflows/publish-image.yml

Kubernetes (next step, not required for using the image)
Use this image in a Deployment:

containers:
  - name: app
    image: ghcr.io/simar-devops/docker-flask-sample:v0.1.4
    ports:
      - containerPort: 8080
    readinessProbe:
      httpGet: { path: /healthz, port: 8080 }
    livenessProbe:
      httpGet: { path: /healthz, port: 8080 }

Dev notes
Runs as non-root, served by Gunicorn, UTF-8 fix, /healthz endpoint.

Multi-arch ready via Buildx in CI.

