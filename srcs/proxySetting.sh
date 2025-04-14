#!/bin/sh

ENV_FILE="./srcs/.env"
HTTP_PROXY_VALUE=$(env | grep "^HTTP_PROXY=" | cut -d '=' -f 2)
HTTPS_PROXY_VALUE=$(env | grep "^HTTPS_PROXY=" | cut -d '=' -f 2)

sed -i '/# proxy setting/d' "$ENV_FILE"
sed -i '/^HTTP_PROXY=/d' "$ENV_FILE"
sed -i '/^HTTPS_PROXY=/d' "$ENV_FILE"

{
  echo "# proxy setting"
  echo "HTTP_PROXY=$HTTP_PROXY_VALUE"
  echo "HTTPS_PROXY=$HTTPS_PROXY_VALUE"
} >> "$ENV_FILE"

printf "\033[38;5;47mProxy setting is done.\033[0m\n"
