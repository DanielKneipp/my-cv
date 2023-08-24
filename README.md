Build pdf with a container

```bash
make docker-build
TARGETS=all make docker-run
# TARGETS=bib make docker-run
# TARGETS=pdf make docker-run
# TARGETS=letter make docker-run
```

Build and develop with [devcontainers](https://code.visualstudio.com/docs/remote/containers)

> It can take several minutes for the image of the devcontainer to get built for the first time

```bash
make all
```
