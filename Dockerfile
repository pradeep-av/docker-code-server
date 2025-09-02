# Start from linuxserver/code-server base image
FROM lscr.io/linuxserver/code-server:latest

# Install curl, wget, tar, and other necessary tools
RUN apt-get update && apt-get install -y lsb-release curl wget tar gnupg2 apt-transport-https ca-certificates build-essential jq

# Install Golang (example version 1.24.6)
RUN wget https://go.dev/dl/go1.24.6.linux-amd64.tar.gz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf go1.24.6.linux-amd64.tar.gz \
    && rm go1.24.6.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >/etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce-cli

# Clean up apt cache to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Default command and entrypoint remain unchanged (inherited)
