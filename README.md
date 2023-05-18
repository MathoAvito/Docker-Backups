<p align="center">
  <a href="https://www.docker.com/">
    <img src="https://cdn.worldvectorlogo.com/logos/docker.svg" alt="Docker" width="150">
  </a>
</p>

# Docker Backups

This repository houses the Docker configurations for my Jenkins lab setup. It includes the Dockerfile and docker-compose configurations that aid in making the lab environment portable and dynamic.

## Structure of the Repository

Here's a quick overview of what's in this repository:

- `./Jenkins`: This directory holds all the resources required for our Jenkins lab setup.

## File Descriptions

- [jenkins.Dockerfile](./Jenkins/Jenkins.Dockerfile)- This Dockerfile holds the docker configurations, application installations, and plugins utilized in the lab. It allows for the encapsulation of all these details into a Docker image, making our lab environment portable and easy to set up.

- [docker-compose.yml](./Jenkins/docker-compose.yml)- This docker-compose file is used to spin up the Jenkins container. It also mounts the `jenkins_home` directory to the host machine, allowing for persistent storage of the Jenkins data.