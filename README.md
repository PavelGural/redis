# Redis

This repository contains the infrastructure as code (IaC) components necessary to deploy a Minikube Kubernetes cluster, a Redis server via Helm, and a redis-client Helm chart to interact with the Redis server. Additionally, there are scripts to set and retrieve values from the Redis server.

## Pre-requisites  

Ensure the following tools are installed on your machine before proceeding:  

- kubectl
- Helm
- VirtualBox (for Linux)
- Docker (for macOS)
  
## Usage

All command below should be executed from the root of this repo.

To deploy and manage the required infrastructure, follow these steps:

### Install and Start Minikube

Run the script to install Minikube and start the Minikube cluster:

```bash
bash scripts/manage_minikube.sh install
bash scripts/manage_minikube.sh start
```

This script will detect your OS (Linux or macOS) and will install Minikube if it is not already installed. It will then start the Minikube cluster using the appropriate hypervisor (VirtualBox for Linux and docker for macOS).

### Deploy Redis Server

Execute the script to deploy the Redis server on the cluster:

``` bash
bash scripts/deploy_redis_server.sh
```

### Deploy Redis Client Application

``` bash
bash scripts/deploy_redis_client.sh
```

### Set and Get Values from Redis

The required values for the Redis are hardcoded in the [script](./scripts/manage_redis.sh)

To set the key-value pair to Redis:

``` bash
bash scripts/manage_redis.sh set
```

To retrieve the value of the Key from Redis:

``` bash
bash scripts/manage_redis.sh get
```
