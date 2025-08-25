# Base image with Debian (bookworm for newer glibc)
FROM debian:bookworm-slim

# Optional version selector
ARG NEOVIM_VERSION

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    make \
    python3 \
    python3-pip \
    nodejs \
    npm \
    zsh \
    bash \
    ca-certificates \
    tar \
    gzip \
    jq \
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

CMD ["nvim"]
