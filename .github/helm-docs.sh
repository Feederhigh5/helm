#!/bin/bash
set -euo pipefail

HELM_DOCS_VERSION="1.11.0"

# install helm-docs
curl --silent --show-error --fail --location --output /tmp/helm-docs.tar.gz https://github.com/norwoodj/helm-docs/releases/download/v"${HELM_DOCS_VERSION}"/helm-docs_"${HELM_DOCS_VERSION}"_Linux_x86_64.tar.gz
tar -xf /tmp/helm-docs.tar.gz helm-docs

# validate docs
./helm-docs

# Set git user config
git config --global user.email "helm-docs-bot@example.com"
git config --global user.name "helm-docs-bot"

echo "github ref: ${GITHUB_HEAD_REF}"

# Get the current branch name
CURRENT_BRANCH=$(echo "${GITHUB_REF#refs/heads/}")

echo "Current branch: ${CURRENT_BRANCH}"

# Checkout the current branch
git checkout "${CURRENT_BRANCH}"

# Commit the changes made by helm-docs
git add .
git commit -m "Update documentation"

# Push the changes to the branch
git push origin "${CURRENT_BRANCH}"