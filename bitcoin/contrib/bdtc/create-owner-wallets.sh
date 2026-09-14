#!/usr/bin/env bash
set -euo pipefail

cli="${BDTC_CLI:-bitcoin-cli}"

for wallet in bdtc_personal bdtc_gift bdtc_project; do
    if ! "$cli" listwallets | grep -Fqx "\"$wallet\""; then
        "$cli" createwallet "$wallet" false false "" false true
    fi
done

echo "BDTC owner wallet addresses:"
printf 'personal (5,000,000 BDTC): '
"$cli" -rpcwallet=bdtc_personal getnewaddress "personal" bech32
printf 'gift (2,000,000 BDTC): '
"$cli" -rpcwallet=bdtc_gift getnewaddress "gift" bech32
printf 'project (3,000,000 BDTC): '
"$cli" -rpcwallet=bdtc_project getnewaddress "project" bech32

echo
echo "Back up each wallet with:"
echo "  $cli -rpcwallet=bdtc_personal backupwallet <private-backup-path>"
echo "  $cli -rpcwallet=bdtc_gift backupwallet <private-backup-path>"
echo "  $cli -rpcwallet=bdtc_project backupwallet <private-backup-path>"