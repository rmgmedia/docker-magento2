#!/bin/bash
redis_fpc_args=()
if [[ "${MAGENTO_REDIS_FPC_SERVER}" ]]; then
  redis_fpc_args+=("--page-cache-redis-server=$MAGENTO_REDIS_FPC_SERVER")
fi
if [[ "${MAGENTO_REDIS_FPC_PORT}" ]]; then
  redis_fpc_args+=("--page-cache-redis-port=$MAGENTO_REDIS_FPC_PORT")
fi
if [[ "${MAGENTO_REDIS_FPC_DATABASE}" ]]; then
  redis_fpc_args+=("--page-cache-redis-db=$MAGENTO_REDIS_FPC_DATABASE")
fi
if [[ "${MAGENTO_REDIS_FPC_PASSWORD}" ]]; then
  redis_fpc_args+=("--page-cache-redis-password=$MAGENTO_REDIS_FPC_PASSWORD")
fi
if [[ "${MAGENTO_REDIS_FPC_COMPRESS_DATA}" ]]; then
  redis_fpc_args+=("--page-cache-redis-compress-data=$MAGENTO_REDIS_FPC_COMPRESS_DATA")
fi
echo "Configuring Redis page cache: /var/www/magento/bin/magento setup:config:set --page-cache=redis ${redis_fpc_args[@]}"
/var/www/magento/bin/magento setup:config:set --page-cache=redis "${redis_fpc_args[@]}"
