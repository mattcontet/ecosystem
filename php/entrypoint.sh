#!/usr/bin/env sh
set -euo pipefail

/etc/init.d/cron start

exec "$@"