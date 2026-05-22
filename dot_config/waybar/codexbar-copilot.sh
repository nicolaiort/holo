#!/usr/bin/env bash
set -euo pipefail

data="$(codexbar usage --json --provider copilot)"
used="$(jq -r '.[0].usage.primary.usedPercent | floor' <<<"$data")"
provider="$(jq -r '.[0].provider // "codex"' <<<"$data")"
login="$(jq -r '.[0].usage.loginMethod // "unknown"' <<<"$data")"
updated="$(jq -r '.[0].usage.updatedAt // ""' <<<"$data")"

if (( used >= 90 )); then
  class="critical"
elif (( used >= 75 )); then
  class="high"
elif (( used >= 50 )); then
  class="mid"
else
  class="low"
fi

jq -nc \
  --arg text "$ {used}%" \
  --arg tooltip "Provider: ${provider}\nLogin: ${login}\nUpdated: ${updated}" \
  --arg class "$class" \
  '{text:$text, tooltip:$tooltip, class:$class}'