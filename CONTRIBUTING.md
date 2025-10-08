# Contributing

- **Branching:** `feature/*`, `fix/*`, `chore/*`
- **Commits:** Conventional Commits (e.g., `feat: add healthz endpoint`)
- **PRs:** Small and focused. Note risk & rollback. Use the PR template.

## Local checks (lightweight)
- Keep Dockerfile minimal, non-root, with a healthcheck.
- Python files: keep imports tidy and readable.
- Tag releases semantically (e.g., `v0.1.5`) so CI can publish to GHCR.
