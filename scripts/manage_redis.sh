#!/bin/bash

MODE=$1

if [ $# -lt 1 ]; then
    echo "Error: Please specify the mode ('set' or 'get')."
    exit 1
fi

REDIS_KEY="TestKey"
REDIS_VALUE="TestValue"
REDIS_NAMESPACE=redis
REDIS_PASSWORD=$(kubectl get secret --namespace redis redis -o jsonpath="{.data.redis-password}" | base64 -d)
REDIS_POD_CLIENT_NAME=$(kubectl get pods -n redis -l app=redis-client -o jsonpath='{.items[0].metadata.name}')

set_redis_key_value() {
    kubectl exec -it -n ${REDIS_NAMESPACE} ${REDIS_POD_CLIENT_NAME} -- redis-cli -h redis-master -p 6379 -a ${REDIS_PASSWORD} set ${REDIS_KEY} ${REDIS_VALUE}
}

get_redis_key_value() {
    kubectl exec -it -n ${REDIS_NAMESPACE} ${REDIS_POD_CLIENT_NAME} -- redis-cli -h redis-master -p 6379 -a ${REDIS_PASSWORD} get ${REDIS_KEY}
}

case $MODE in
set)
    set_redis_key_value
    ;;
get)
    get_redis_key_value
    ;;
*)
    echo "Invalid mode: $MODE. Please specify 'set' or 'get'."
    exit 1
    ;;
esac
echo "Redis command ($MODE) completed successfully."
