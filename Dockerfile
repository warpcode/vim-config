# Base image with Debian (bookworm for newer glibc)
FROM debian:bookworm-slim

# Optional version selector
ARG NEOVIM_VERSION
ARG NODE_MAJOR=20 # Added: Specify the Node.js major version (e.g., 18, 20, 22)

# User configuration
ARG USER_UID=1000
ARG USER_GID=1000
ARG USER_NAME=dev

# Set frontend to noninteractive for apt commands
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages (excluding nodejs and npm, which will be installed from NodeSource)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    make \
    python3 \
    python3-pip \
    python3-venv \
    zsh \
    bash \
    ca-certificates \
    tar \
    gzip \
    jq \
    ripgrep \
    sudo \
    build-essential \
    cmake \
    pkg-config \
    unzip \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js from NodeSource official repositories
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && chmod go+r /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI (gh) from its official repository
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

# Install Neovim via GitHub API (arch-aware tarball)
RUN set -e; \
    ARCH=$(dpkg --print-architecture); \
    case "$ARCH" in \
      amd64)   PATTERN="^(nvim-linux64|nvim-linux-x86_64)\\.tar\\.gz$" ;; \
      arm64)   PATTERN="^(nvim-linux-arm64|nvim-linux-aarch64)\\.tar\\.gz$" ;; \
      *)       echo "Unsupported architecture: ${ARCH}"; exit 1 ;; \
    esac; \
    if [ -z "$NEOVIM_VERSION" ] || [ "$NEOVIM_VERSION" = "latest" ]; then \
        API_URL="https://api.github.com/repos/neovim/neovim/releases/latest"; \
    elif [ "$NEOVIM_VERSION" = "nightly" ]; then \
        API_URL="https://api.github.com/repos/neovim/neovim/releases/tags/nightly"; \
    else \
        API_URL="https://api.github.com/repos/neovim/neovim/releases/tags/v${NEOVIM_VERSION}"; \
    fi; \
    echo "Detected architecture: ${ARCH}"; \
    echo "Querying ${API_URL} for asset pattern: ${PATTERN}"; \
    RELEASE_JSON=$(curl -fsSL -H 'Accept: application/vnd.github+json' -H 'User-Agent: neovim-setup' "$API_URL"); \
    DOWNLOAD_URL=$(printf "%s" "$RELEASE_JSON" | jq -r --arg re "$PATTERN" '.assets[] | select(.name | test($re)) | .browser_download_url' | head -n1); \
    if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" = "null" ]; then \
        echo "Available assets:"; printf "%s" "$RELEASE_JSON" | jq -r '.assets[].name' || true; \
        echo "Failed to resolve download URL for pattern: ${PATTERN}"; exit 1; \
    fi; \
    echo "Downloading Neovim from $DOWNLOAD_URL"; \
    curl -fSL "$DOWNLOAD_URL" -o /tmp/nvim.tar.gz; \
    tar -xzf /tmp/nvim.tar.gz -C /tmp; \
    cp -r /tmp/nvim-linux*/bin/* /usr/bin/; \
    cp -r /tmp/nvim-linux*/lib/* /usr/lib/ || true; \
    cp -r /tmp/nvim-linux*/share/* /usr/share/ || true; \
    rm -rf /tmp/nvim.tar.gz /tmp/nvim-linux*

# Verify the installation
RUN nvim --version || echo "Warning: Neovim execution test failed"

# Create a non-root user with configurable UID/GID
RUN groupadd --gid "${USER_GID}" "${USER_NAME}" \
    && useradd --uid "${USER_UID}" --gid "${USER_GID}" --shell /bin/bash --create-home "${USER_NAME}" \
    && echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/"${USER_NAME}" \
    && chmod 0440 /etc/sudoers.d/"${USER_NAME}"

# Set the working directory and switch to the new user
WORKDIR /workdir
USER ${USER_NAME}

# Copy Neovim config files to the user's home directory
# The entire build context is copied, excluding items in .dockerignore
RUN mkdir -p /home/${USER_NAME}/.config/nvim
COPY --chown=${USER_NAME}:${USER_GID} . /home/${USER_NAME}/.config/nvim/

# Run Neovim once to install all plugins
RUN nvim --headless -c "Lazy sync" -c "qa!"

# Ensure Tree-sitter modules are compiled
RUN nvim --headless -c "TSInstallSync all" -c "qa!"

# Run Mason to ensure all CLI tools are installed and wait for completion
RUN nvim --headless -c "MasonToolsInstallSync" -c "qa!"

CMD ["nvim"]
