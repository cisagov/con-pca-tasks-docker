# Con-PCA Tasks Docker 🐳 #

[![GitHub Build Status](https://github.com/cisagov/con-pca-tasks-docker/workflows/build/badge.svg)](https://github.com/cisagov/con-pca-tasks-docker/actions/workflows/build.yml)
[![CodeQL](https://github.com/cisagov/con-pca-tasks-docker/workflows/CodeQL/badge.svg)](https://github.com/cisagov/con-pca-tasks-docker/actions/workflows/codeql-analysis.yml)
[![Known Vulnerabilities](https://snyk.io/test/github/cisagov/con-pca-tasks-docker/badge.svg)](https://snyk.io/test/github/cisagov/con-pca-tasks-docker)

## Docker Image ##

[![Docker Pulls](https://img.shields.io/docker/pulls/cisagov/con-pca-tasks-docker)](https://hub.docker.com/r/cisagov/con-pca-tasks-docker)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/cisagov/con-pca-tasks-docker)](https://hub.docker.com/r/cisagov/con-pca-tasks-docker)
[![Platforms](https://img.shields.io/badge/platforms-amd64%20%7C%20arm%2Fv6%20%7C%20arm%2Fv7%20%7C%20arm64%20%7C%20ppc64le%20%7C%20s390x-blue)](https://hub.docker.com/r/cisagov/con-pca-tasks-docker/tags)

This project's purpose is to containerize [Con-PCA-Tasks](https://github.com/cisagov/con-pca-tasks)
project as part of our cicd pipeline.

## Related Con-PCA Repositories ##

- [con-pca-api](https://github.com/cisagov/con-pca-api)
- [con-pca-cicd](https://github.com/cisagov/con-pca-cicd)
- [con-pca-web](https://github.com/cisagov/con-pca-web)
- [con-pca-tasks](https://github.com/cisagov/con-pca-web)

## Running ##

### Running with Docker Compose ###

1. Start the container and detach:

    ```console
    docker compose up --detach
    ```

## Updating your container ##

### Docker Compose ###

1. Pull the new image from Docker Hub:

    ```console
    docker compose pull
    ```

1. Recreate the running container by following the [previous instructions](#running-with-docker-compose):

    ```console
    docker compose up --detach
    ```

## Image tags ##

The images of this container are tagged with [semantic
versions](https://semver.org) of the underlying con-pca-tasks project
that they containerize.  It is recommended that most users use a version tag
(e.g. `:0.0.1`).

| Image:tag | Description |
|-----------|-------------|
|`cisagov/con-pca-tasks:1.2.3`| An exact release version. |
|`cisagov/con-pca-tasks:1.2`| The most recent release matching the major and minor version numbers. |
|`cisagov/con-pca-tasks:1`| The most recent release matching the major version number. |
|`cisagov/con-pca-tasks:edge` | The most recent image built from a merge into the `develop` branch of this repository. |
|`cisagov/con-pca-tasks:nightly` | A nightly build of the `develop` branch of this repository. |
|`cisagov/con-pca-tasks:latest`| The most recent release image pushed to a container registry.  Pulling an image using the `:latest` tag [should be avoided.](https://vsupalov.com/docker-latest-tag/) |

See the [tags tab](https://hub.docker.com/r/cisagov/con-pca-tasks/tags) on
Docker Hub for a list of all the supported tags.

## Volumes ##

| Mount point | Purpose        |
|-------------|----------------|
| `/var/log`  |  Log storage   |

## Ports ##

The following ports are exposed by this container:

| Port | Purpose        |
|------|----------------|
| 8080 | Con-PCA Tasks  |

## Environment variables ##

### Required ###

There are no required environment variables as of now.

<!--
| Name  | Purpose | Default |
|-------|---------|---------|
| `REQUIRED_VARIABLE` | Describe its purpose. | `null` |
-->

## Secrets ##

| Filename     | Purpose |
|--------------|---------|
| `quote.txt` | Replaces the secret stored in the library's package data. |

## Building from source ##

Build the image locally using this git repository as the [build context](https://docs.docker.com/engine/reference/commandline/build/#git-repositories):

```console
docker build \
  --build-arg VERSION=0.0.1 \
  --tag cisagov/con-pca-tasks:0.0.1 \
  https://github.com/cisagov/con-pca-tasks-docker.git#develop
```

## Cross-platform builds ##

To create images that are compatible with other platforms, you can use the
[`buildx`](https://docs.docker.com/buildx/working-with-buildx/) feature of
Docker:

1. Copy the project to your machine using the `Code` button above
   or the command line:

    ```console
    git clone https://github.com/cisagov/con-pca-tasks-docker.git
    cd con-pca-tasks-docker
    ```

1. Create the `Dockerfile-x` file with `buildx` platform support:

    ```console
    ./buildx-dockerfile.sh
    ```

1. Build the image using `buildx`:

    ```console
    docker buildx build \
      --file Dockerfile-x \
      --platform linux/amd64 \
      --build-arg VERSION=0.0.1 \
      --output type=docker \
      --tag cisagov/con-pca-tasks:0.0.1 .
    ```

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
