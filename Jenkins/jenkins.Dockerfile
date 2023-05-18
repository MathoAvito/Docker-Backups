# Use specific version of Jenkins
FROM jenkins/jenkins:2.356-jdk8

# Define variables upfront
ARG DOCKER_GID=998

# Switch to root user for installations
USER root

# Perform a single RUN command for package installation
RUN apt-get update -y \
    && apt-get -y install docker.io vim curl unzip awscli zip wget gnupg software-properties-common \
    # Terraform
    && wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    # yq
    && wget https://github.com/mikefarah/yq/releases/download/v4.2.0/yq_linux_amd64 -O /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    # Docker-compose
    && curl -L https://github.com/docker/compose/releases/download/v2.0.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    # Modify Jenkins group
    && groupmod -g $DOCKER_GID jenkins \
    # Jenkins plugins
    && jenkins-plugin --plugins greenballs:1.15.1 gitlab-plugin:1.5.20 generic-webhook-trigger:1.84 amazon-ecr:1.73.v741d474abe74 docker-plugin:1.2.9 docker-workflow:1.29 maven-plugin:3.19 email-ext:2.89 config-file-provider:3.10.0 maven-plugin:3.19 artifactory:3.16.3 terraform:1.0.10 ssh-agent:295.v9ca_a_1c7cc3a_a_ multibranch-scan-webhook-trigger:1.0.9

# Switch back to Jenkins user
USER jenkins