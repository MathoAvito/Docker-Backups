FROM jenkins/jenkins:2.356-jdk8


# Make installations as root user
USER root


# Add the localhost docker GID as env var
ARG DOCKER_GID=998


# System tools installation
RUN apt-get update -y \
    && apt-get -y install \
    docker.io -y \
    vim \
    curl \
    unzip \
    awscli \
    zip \
    wget


# GnuPG installation
RUN apt-get install -y gnupg software-properties-common


# Terraform installation
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list

#RUN apt-get install -y terraform


# yq installation
RUN wget https://github.com/mikefarah/yq/releases/download/v4.2.0/yq_linux_amd64 \ 
    -O /usr/bin/yq && \
    chmod +x /usr/bin/yq


# Docker Installation (docker-compose)
RUN curl -L https://github.com/docker/compose/releases/download/v2.0.1/docker-compose-linux-x86_64 \
    -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose 


# Change the GID of the docker group of the container to the same GID of the localhost
RUN groupmod -g $DOCKER_GID jenkins

# Jenkins plugins installation
RUN jenkins-plugin-cli --plugins \
    greenballs:1.15.1 \
    gitlab-plugin:1.5.20 \
    generic-webhook-trigger:1.84 \
    amazon-ecr:1.73.v741d474abe74 \
    docker-plugin:1.2.9 \
    docker-workflow:1.29 \
    maven-plugin:3.19 \
    email-ext:2.89 \
    config-file-provider:3.10.0 \
    maven-plugin:3.19 \
    artifactory:3.16.3 \
    terraform:1.0.10 \
    ssh-agent:295.v9ca_a_1c7cc3a_a_ \
    multibranch-scan-webhook-trigger:1.0.9


# Change from root user to jenkins
USER jenkins
