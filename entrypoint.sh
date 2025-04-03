#!/bin/bash
set -e

if [ -z "${RUNNER_TOKEN}" ]; then
  echo "RUNNER_TOKEN is not set. Exiting."
  exit 1
fi

if [ -z "${RUNNER_NAME}" ]; then
  RUNNER_NAME=$(hostname)
fi

if [ -z "${GITHUB_REPO_URL}" ]; then
  echo "GITHUB_REPO_URL is not set. Exiting."
  exit 1
fi

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token "${RUNNER_TOKEN}"
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./config.sh \
    --url "${GITHUB_REPO_URL}" \
    --token "${RUNNER_TOKEN}" \
    --name "${RUNNER_NAME}" \
    --work "_work" \
    --unattended \
    --replace

./run.sh &

wait $!
