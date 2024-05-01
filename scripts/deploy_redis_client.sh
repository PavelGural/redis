#!/bin/bash

REDIS_NAMESPACE=redis
REDIS_PASSWORD=$(kubectl get secret --namespace redis redis -o jsonpath="{.data.redis-password}" | base64 --decode)

helm upgrade --install redis-client helm/redis-client \
    --create-namespace \
    --namespace "${REDIS_NAMESPACE}" \
    --set redis.password="${REDIS_PASSWORD}"

kubectl rollout status --timeout=5m -n ${REDIS_NAMESPACE} deployment redis-client
