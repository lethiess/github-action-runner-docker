FROM ubuntu:22.04

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    sudo \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    git \
    lsb-release \
    jq \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create runner user
RUN useradd -m runner
WORKDIR /home/runner

# Download and unpack latest GitHub Runner
RUN RUNNER_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r .tag_name | sed 's/v//') \
    && curl -Ls https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz | tar -xz

# Docker entrypoint script to configure runner at startup
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh && chown runner:runner entrypoint.sh

# Now switch to non-root user
USER runner

ENTRYPOINT ["./entrypoint.sh"]
