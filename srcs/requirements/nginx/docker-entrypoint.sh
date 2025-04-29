#!/bin/sh

set -e

entrypoint_log() {
  if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
    echo "$@"
  fi
}

if [ "$1" = "nginx" ] || [ "$1" = "nginx-debug" ]; then
  if /usr/bin/find "/docker-entrypoint.d/" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v; then
    entrypoint_log "$0: /docker-entrypoint.d/ is not empty, will attempt to perform configuration"

    entrypoint_log "$0: Looking for shell scripts in /docker-entrypoint.d/"
