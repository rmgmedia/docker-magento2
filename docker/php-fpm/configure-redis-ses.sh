#!/bin/bash
redis_ses_args=()
if [[ "${MAGENTO_REDIS_SES_SERVER}" ]]; then
  redis_ses_args+=("--session-save-redis-host=$MAGENTO_REDIS_SES_SERVER")
fi
if [[ "${MAGENTO_REDIS_SES_PORT}" ]]; then
  redis_ses_args+=("--session-save-redis-port=$MAGENTO_REDIS_SES_PORT")
fi
if [[ "${MAGENTO_REDIS_SES_DATABASE}" ]]; then
  redis_ses_args+=("--session-save-redis-db=$MAGENTO_REDIS_SES_DATABASE")
fi
if [[ "${MAGENTO_REDIS_SES_PASSWORD}" ]]; then
  redis_ses_args+=("--session-save-redis-password=$MAGENTO_REDIS_SES_PASSWORD")
fi
if [[ "${MAGENTO_REDIS_SES_TIMEOUT}" ]]; then
  redis_ses_args+=("--session-save-redis-timeout=$MAGENTO_REDIS_SES_TIMEOUT")
fi
if [[ "${MAGENTO_REDIS_SES_PERSISTENT_ID}" ]]; then
  redis_ses_args+=("--session-save-redis-persistent-id=$MAGENTO_REDIS_SES_PERSISTENT_ID")
fi
if [[ "${MAGENTO_REDIS_SES_COMPRESSION_THRESHOLD}" ]]; then
  redis_ses_args+=("--session-save-redis-compression-threshold=$MAGENTO_REDIS_SES_COMPRESSION_THRESHOLD")
fi
if [[ "${MAGENTO_REDIS_SES_COMPRESSION_LIB}" ]]; then
  redis_ses_args+=("--session-save-redis-compression-lib=$MAGENTO_REDIS_SES_COMPRESSION_LIB")
fi
if [[ "${MAGENTO_REDIS_SES_LOG_LEVEL}" ]]; then
  redis_ses_args+=("--session-save-redis-log-level=$MAGENTO_REDIS_SES_LOG_LEVEL")
fi
if [[ "${MAGENTO_REDIS_SES_MAX_CONCURRENCY}" ]]; then
  redis_ses_args+=("--session-save-redis-max-concurrency=$MAGENTO_REDIS_SES_MAX_CONCURRENCY")
fi
if [[ "${MAGENTO_REDIS_SES_BREAK_AFTER_FRONTEND}" ]]; then
  redis_ses_args+=("--session-save-redis-break-after-frontend=$MAGENTO_REDIS_SES_BREAK_AFTER_FRONTEND")
fi
if [[ "${MAGENTO_REDIS_SES_BREAK_AFTER_ADMINHTML}" ]]; then
  redis_ses_args+=("--session-save-redis-break-after-adminhtml=$MAGENTO_REDIS_SES_BREAK_AFTER_ADMINHTML")
fi
if [[ "${MAGENTO_REDIS_SES_FIRST_LIFETIME}" ]]; then
  redis_ses_args+=("--session-save-redis-first-lifetime=$MAGENTO_REDIS_SES_FIRST_LIFETIME")
fi
if [[ "${MAGENTO_REDIS_SES_BOT_LIFETIME}" ]]; then
  redis_ses_args+=("--session-save-redis-bot-first-lifetime=$MAGENTO_REDIS_SES_BOT_LIFETIME")
fi
if [[ "${MAGENTO_REDIS_SES_DISABLE_LOCKING}" ]]; then
  redis_ses_args+=("--session-save-redis-disable-locking=$MAGENTO_REDIS_SES_DISABLE_LOCKING")
fi
if [[ "${MAGENTO_REDIS_SES_MIN_LIFETIME}" ]]; then
  redis_ses_args+=("--session-save-redis-min-lifetime=$MAGENTO_REDIS_SES_MIN_LIFETIME")
fi
if [[ "${MAGENTO_REDIS_SES_MAX_LIFETIME}" ]]; then
  redis_ses_args+=("--session-save-redis-max-lifetime=$MAGENTO_REDIS_SES_MAX_LIFETIME")
fi
echo "Configuring Redis sessions: /var/www/magento/bin/magento setup:config:set --session-save=redis ${redis_ses_args[@]}"
/var/www/magento/bin/magento setup:config:set --session-save=redis "${redis_ses_args[@]}"
