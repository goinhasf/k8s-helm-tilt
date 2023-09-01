#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# If it's the firt install of mkcert, run
mkcert -install

# Generate certificate for domain "docker.localhost", "domain.local" and their sub-domains
mkcert -cert-file $SCRIPT_DIR/local-cert.pem -key-file $SCRIPT_DIR/local-key.pem "*.cluster.test" "cluster.test"

CERT="$(cat $SCRIPT_DIR/local-cert.pem | sed 's/^/    /')"
KEY="$(cat $SCRIPT_DIR/local-key.pem | sed 's/^/    /')"

cat << EOF > $SCRIPT_DIR/../local-values.yaml
tls: 
  crt: |
$CERT
  key: | 
$KEY
EOF