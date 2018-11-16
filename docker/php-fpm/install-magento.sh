#!/bin/bash
if [ -z "$(ls -A /var/www/magento)" ]; then
  echo "Downloading Magento installation from https://repo.magento.com"
  composer create-project --repository=https://repo.magento.com/ magento/project-community-edition /var/www/magento

  args=()
  if [[ "${MAGENTO_ADMIN_FIRSTNAME}" ]]; then
    args+=("--admin-firstname=$MAGENTO_ADMIN_FIRSTNAME")
  fi
  if [[ "${MAGENTO_ADMIN_LASTNAME}" ]]; then
    args+=("--admin-lastname=$MAGENTO_ADMIN_LASTNAME")
  fi
  if [[ "${MAGENTO_ADMIN_EMAIL}" ]]; then
    args+=("--admin-email=$MAGENTO_ADMIN_EMAIL")
  fi
  if [[ "${MAGENTO_ADMIN_USER}" ]]; then
    args+=("--admin-user=$MAGENTO_ADMIN_USER")
  fi
  if [[ "${MAGENTO_ADMIN_PASSWORD}" ]]; then
    args+=("--admin-password=$MAGENTO_ADMIN_PASSWORD")
  fi
  if [[ "${MAGENTO_BASE_URL}" ]]; then
    args+=("--base-url=$MAGENTO_BASE_URL")
  fi
  if [[ "${MAGENTO_BACKEND_FRONTNAME}" ]]; then
    args+=("--backend-frontname=$MAGENTO_BACKEND_FRONTNAME")
  fi
  if [[ "${MAGENTO_DB_HOST}" ]]; then
    args+=("--db-host=$MAGENTO_DB_HOST")
  fi
  if [[ "${MAGENTO_DB_NAME}" ]]; then
    args+=("--db-name=$MAGENTO_DB_NAME")
  fi
  if [[ "${MAGENTO_DB_USER}" ]]; then
    args+=("--db-user=$MAGENTO_DB_USER")
  fi
  if [[ "${MAGENTO_DB_PASSWORD}" ]]; then
    args+=("--db-password=$MAGENTO_DB_PASSWORD")
  fi
  if [[ "${MAGENTO_DB_PREFIX}" ]]; then
    args+=("--db-prefix=$MAGENTO_DB_PREFIX")
  fi
  if [[ "${MAGENTO_LANGUAGE}" ]]; then
    args+=("--language=$MAGENTO_LANGUAGE")
  fi
  if [[ "${MAGENTO_CURRENCY}" ]]; then
    args+=("--currency=$MAGENTO_CURRENCY")
  fi
  if [[ "${MAGENTO_TIMEZONE}" ]]; then
    args+=("--timezone=$MAGENTO_TIMEZONE")
  fi
  if [[ "${MAGENTO_USE_REWRITES}" ]]; then
    args+=("--use-rewrites=$MAGENTO_USE_REWRITES")
  fi
  if [[ "${MAGENTO_USE_SECURE}" ]]; then
    args+=("--use-secure=$MAGENTO_USE_SECURE")
  fi
  if [[ "${MAGENTO_BASE_URL_SECURE}" ]]; then
    args+=("--base-url-secure=$MAGENTO_BASE_URL_SECURE")
  fi
  if [[ "${MAGENTO_USE_SECURE_ADMIN}" ]]; then
    args+=("--use-secure-admin=$MAGENTO_USE_SECURE_ADMIN")
  fi
  if [[ "${MAGENTO_ADMIN_USE_SECURITY_KEY}" ]]; then
    args+=("--admin-use-security-key=$MAGENTO_ADMIN_USE_SECURITY_KEY")
  fi
  if [[ "${MAGENTO_SESSION_SAVE}" ]]; then
    args+=("--session-save=$MAGENTO_SESSION_SAVE")
  fi
  if [[ "${MAGENTO_KEY}" ]]; then
    args+=("--key=$MAGENTO_KEY")
  fi
  if [[ "${MAGENTO_CLEANUP_DATABASE}" ]]; then
    args+=("--cleanup-database=$MAGENTO_CLEANUP_DATABASE")
  fi
  if [[ "${MAGENTO_DB_INIT_STATEMENTS}" ]]; then
    args+=("--db-init-statements=$MAGENTO_DB_INIT_STATEMENTS")
  fi
  if [[ "${MAGENTO_SALES_ORDER_INCREMENT_PREFIX}" ]]; then
    args+=("--sales-order-increment-prefix=$MAGENTO_SALES_ORDER_INCREMENT_PREFIX")
  fi
  if [[ "${MAGENTO_AMQP_HOST}" ]]; then
    args+=("--amqp-host=$MAGENTO_AMQP_HOST")
  fi
  if [[ "${MAGENTO_AMQP_PORT}" ]]; then
    args+=("--amqp-port=$MAGENTO_AMQP_HOST")
  fi
  if [[ "${MAGENTO_AMQP_USER}" ]]; then
    args+=("--amqp-user=$MAGENTO_AMQP_USER")
  fi
  if [[ "${MAGENTO_AMQP_PASSWORD}" ]]; then
    args+=("--amqp-password=$MAGENTO_AMQP_PASSWORD")
  fi
  if [[ "${MAGENTO_AMQP_VIRTUALPORT}" ]]; then
    args+=("--amqp-virtualport=$MAGENTO_AMQP_VIRTUALPORT")
  fi
  if [[ "${MAGENTO_AMQP_SSL}" ]]; then
    args+=("--amqp-ssl=$MAGENTO_AMQP_SSL")
  fi
  echo "Running Magento install: /var/www/magento/bin/magento setup:install ${args[@]}"
  /var/www/magento/bin/magento setup:install "${args[@]}"
else
  echo "Magento installation detected."
  exit 1
fi
