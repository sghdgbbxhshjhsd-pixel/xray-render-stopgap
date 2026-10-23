#!/bin/sh
set -eu
# Railway injects $PORT; Xray must listen on it. TLS is terminated by Railway edge (https domain), so WS is plain inside, TLS outside = VLESS+WS+TLS from client view.
: "${UUID:?Set UUID env in Railway Variables}"
WS_PATH="${WS_PATH:-/ray}"
PORT="${PORT:-8080}"
sed -i "s/UUID_PLACEHOLDER/${UUID}/g; s|WS_PATH_PLACEHOLDER|${WS_PATH}|g; s/\"port\": 8080/\"port\": ${PORT}/" /usr/local/etc/xray/config.json
exec /usr/local/bin/xray run -config /usr/local/etc/xray/config.json
