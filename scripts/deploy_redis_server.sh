#!/bin/bash

# Redis version is 7.2.4
REDIS_HELM_VERSION="19.1.5"
REDIS_NAMESPACE="redis"

helm upgrade --install redis oci://registry-1.docker.io/bitnamicharts/redis \
    --create-namespace \
    --namespace "${REDIS_NAMESPACE}" \
    --version "${REDIS_VERSION}"

kubectl rollout status --timeout=5m -n ${REDIS_NAMESPACE} statefulset redis-master
kubectl rollout status --timeout=5m -n ${REDIS_NAMESPACE} statefulset redis-replicas
