# docker-flask-sample

Small Flask app packaged with Docker & served by Gunicorn. Health endpoint at `/healthz`.

## Image (GitHub Container Registry)

**Current release:**
ghcr.io/simar-devops/docker-flask-sample:v0.1.4

bash
Copy code

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

yaml
Copy code
containers:
  - name: app
    image: ghcr.io/simar-devops/docker-flask-sample:v0.1.4
    ports:
      - containerPort: 8000
    readinessProbe:
      httpGet: { path: /healthz, port: 8000 }
    livenessProbe:
      httpGet: { path: /healthz, port: 8000 }
Dev notes
Runs as non-root, served by Gunicorn, UTF-8 fix, /healthz endpoint.

Multi-arch ready via Buildx in CI.
