# GitHub Action Runner Docker

Run a GitHub Action runner in a Docker container instead of installing it locally on your machine. This makes it easy to set up, tear down, and manage GitHub Actions runners in isolated environments.

## Features

- Self-hosted GitHub Actions runner in a Docker container
- Automatically configures using GitHub repository URL and runner token
- Customizable runner name
- Support for adding custom host mappings

## Prerequisites

- Docker installed on your host machine
- A GitHub repository with permissions to add runners
- A runner registration token from GitHub

## Quick Start

1. Get a runner token from your GitHub repository:
   - Go to your repository on GitHub
   - Navigate to Settings > Actions > Runners
   - Click "New self-hosted runner"
   - Copy the token value (looks like `AATO3WU2SEJXXXXX2RQ5CXTH52Z4E`)

2. Run the Docker container:

```bash
docker run -d --name github-action-runner \
  -e GITHUB_REPO_URL="https://github.com/username/repository" \
  -e RUNNER_TOKEN="YOUR_RUNNER_TOKEN" \
  -e RUNNER_NAME="your-runner-name" \
  github-action-runner
```

## Environment Variables

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `GITHUB_REPO_URL` | URL of your GitHub repository | Yes | N/A |
| `RUNNER_TOKEN` | Runner registration token | Yes | N/A |
| `RUNNER_NAME` | Name for your runner | No | Machine hostname |

## Advanced Usage

### Adding Custom Host Mappings

You can add custom host mappings using the `--add-host` flag. This is useful when your workflows need to access local services or internal networks.

Example:

```bash
docker run -d --name github-action-runner \
  --add-host example.local:192.168.1.100 \
  --add-host api.example.local:192.168.1.101 \
  -e GITHUB_REPO_URL="https://github.com/username/repository" \
  -e RUNNER_TOKEN="YOUR_RUNNER_TOKEN" \
  -e RUNNER_NAME="custom-runner-name" \
  github-action-runner
```

## Building the Image

To build the Docker image yourself:

```bash
git clone https://github.com/yourusername/github-action-runner-docker.git
cd github-action-runner-docker
docker build -t github-action-runner .
```

## Troubleshooting

- If the runner fails to start, check your token is valid and hasn't expired
- Verify network connectivity to GitHub from inside the container
- Check logs with `docker logs github-action-runner`

