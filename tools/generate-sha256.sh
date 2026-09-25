#!/usr/bin/env bash
set -euo pipefail

target="${1:-.}"
find "$target" -type f ! -path '*/.git/*' ! -name 'SHA256SUMS.txt' -print0 | sort -z | xargs -0 sha256sum
