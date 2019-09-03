#!/usr/bin/env bash
set -euxo pipefail

/etc/init.d/cron start

exec "$@"