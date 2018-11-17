#!/bin/bash
if [ -z "$(ls -A /var/www/magento)" ]; then
  echo "Downloading Magento installation from https://repo.magento.com"
  composer create-project --repository=https://repo.magento.com/ magento/project-community-edition /var/www/magento

  install_args=()
  if [[ "${MAGENTO_ADMIN_FIRSTNAME}" ]]; then
    install_args+=("--admin-firstname=$MAGENTO_ADMIN_FIRSTNAME")
  fi
  if [[ "${MAGENTO_ADMIN_LASTNAME}" ]]; then
    install_args+=("--admin-lastname=$MAGENTO_ADMIN_LASTNAME")
  fi
  if [[ "${MAGENTO_ADMIN_EMAIL}" ]]; then
    install_args+=("--admin-email=$MAGENTO_ADMIN_EMAIL")
  fi
  if [[ "${MAGENTO_ADMIN_USER}" ]]; then
    install_args+=("--admin-user=$MAGENTO_ADMIN_USER")
  fi
  if [[ "${MAGENTO_ADMIN_PASSWORD}" ]]; then
    install_args+=("--admin-password=$MAGENTO_ADMIN_PASSWORD")
  fi
  if [[ "${MAGENTO_BASE_URL}" ]]; then
    install_args+=("--base-url=$MAGENTO_BASE_URL")
  fi
  if [[ "${MAGENTO_BACKEND_FRONTNAME}" ]]; then
    install_args+=("--backend-frontname=$MAGENTO_BACKEND_FRONTNAME")
  fi
  if [[ "${MAGENTO_DB_HOST}" ]]; then
    install_args+=("--db-host=$MAGENTO_DB_HOST")
  fi
  if [[ "${MAGENTO_DB_NAME}" ]]; then
    install_args+=("--db-name=$MAGENTO_DB_NAME")
  fi
  if [[ "${MAGENTO_DB_USER}" ]]; then
    install_args+=("--db-user=$MAGENTO_DB_USER")
  fi
  if [[ "${MAGENTO_DB_PASSWORD}" ]]; then
    install_args+=("--db-password=$MAGENTO_DB_PASSWORD")
  fi
  if [[ "${MAGENTO_DB_PREFIX}" ]]; then
    install_args+=("--db-prefix=$MAGENTO_DB_PREFIX")
  fi
  if [[ "${MAGENTO_LANGUAGE}" ]]; then
    install_args+=("--language=$MAGENTO_LANGUAGE")
  fi
  if [[ "${MAGENTO_CURRENCY}" ]]; then
    install_args+=("--currency=$MAGENTO_CURRENCY")
  fi
  if [[ "${MAGENTO_TIMEZONE}" ]]; then
    install_args+=("--timezone=$MAGENTO_TIMEZONE")
  fi
  if [[ "${MAGENTO_USE_REWRITES}" ]]; then
    install_args+=("--use-rewrites=$MAGENTO_USE_REWRITES")
  fi
  if [[ "${MAGENTO_USE_SECURE}" ]]; then
    install_args+=("--use-secure=$MAGENTO_USE_SECURE")
  fi
  if [[ "${MAGENTO_BASE_URL_SECURE}" ]]; then
    install_args+=("--base-url-secure=$MAGENTO_BASE_URL_SECURE")
  fi
  if [[ "${MAGENTO_USE_SECURE_ADMIN}" ]]; then
    install_args+=("--use-secure-admin=$MAGENTO_USE_SECURE_ADMIN")
  fi
  if [[ "${MAGENTO_ADMIN_USE_SECURITY_KEY}" ]]; then
    install_args+=("--admin-use-security-key=$MAGENTO_ADMIN_USE_SECURITY_KEY")
  fi
  if [[ "${MAGENTO_SESSION_SAVE}" ]]; then
    install_args+=("--session-save=$MAGENTO_SESSION_SAVE")
  fi
  if [[ "${MAGENTO_KEY}" ]]; then
    install_args+=("--key=$MAGENTO_KEY")
  fi
  if [[ "${MAGENTO_CLEANUP_DATABASE}" ]]; then
    install_args+=("--cleanup-database=$MAGENTO_CLEANUP_DATABASE")
  fi
  if [[ "${MAGENTO_DB_INIT_STATEMENTS}" ]]; then
    install_args+=("--db-init-statements=$MAGENTO_DB_INIT_STATEMENTS")
  fi
  if [[ "${MAGENTO_SALES_ORDER_INCREMENT_PREFIX}" ]]; then
    install_args+=("--sales-order-increment-prefix=$MAGENTO_SALES_ORDER_INCREMENT_PREFIX")
  fi
  if [[ "${MAGENTO_AMQP_HOST}" ]]; then
    install_args+=("--amqp-host=$MAGENTO_AMQP_HOST")
  fi
  if [[ "${MAGENTO_AMQP_PORT}" ]]; then
    install_args+=("--amqp-port=$MAGENTO_AMQP_HOST")
  fi
  if [[ "${MAGENTO_AMQP_USER}" ]]; then
    install_args+=("--amqp-user=$MAGENTO_AMQP_USER")
  fi
  if [[ "${MAGENTO_AMQP_PASSWORD}" ]]; then
    install_args+=("--amqp-password=$MAGENTO_AMQP_PASSWORD")
  fi
  if [[ "${MAGENTO_AMQP_VIRTUALPORT}" ]]; then
    install_args+=("--amqp-virtualport=$MAGENTO_AMQP_VIRTUALPORT")
  fi
  if [[ "${MAGENTO_AMQP_SSL}" ]]; then
    install_args+=("--amqp-ssl=$MAGENTO_AMQP_SSL")
  fi
  echo "Running Magento install: /var/www/magento/bin/magento setup:install ${install_args[@]}"
  /var/www/magento/bin/magento setup:install "${install_args[@]}"

  redis_obj_args=()
  if [[ "${MAGENTO_REDIS_OBJ_SERVER}" ]]; then
    redis_obj_args+=("--cache-backend-redis-server=$MAGENTO_REDIS_OBJ_SERVER")
  fi
  if [[ "${MAGENTO_REDIS_OBJ_PORT}" ]]; then
    redis_obj_args+=("--cache-backend-redis-port=$MAGENTO_REDIS_OBJ_PORT")
  fi
  if [[ "${MAGENTO_REDIS_OBJ_DATABASE}" ]]; then
    redis_obj_args+=("--cache-backend-redis-db=$MAGENTO_REDIS_OBJ_DATABASE")
  fi
  if [[ "${MAGENTO_REDIS_OBJ_PASSWORD}" ]]; then
    redis_obj_args+=("--cache-backend-redis-password=$MAGENTO_REDIS_OBJ_PASSWORD")
  fi
  echo "Setting up Redis object cache: /var/www/magento/bin/magento setup:config:set --cache-backend=redis ${redis_obj_args[@]}"
  /var/www/magento/bin/magento setup:config:set --cache-backend=redis "${redis_obj_args[@]}"

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
  echo "Setting up Redis page cache: /var/www/magento/bin/magento setup:config:set --page-cache=redis ${redis_fpc_args[@]}"
  /var/www/magento/bin/magento setup:config:set --page-cache=redis "${redis_fpc_args[@]}"

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
  echo "Setting up Redis sessions: /var/www/magento/bin/magento setup:config:set --session-save=redis ${redis_ses_args[@]}"
  /var/www/magento/bin/magento setup:config:set --session-save=redis "${redis_ses_args[@]}"
else
  echo "Magento installation detected."
  exit 1
fi
