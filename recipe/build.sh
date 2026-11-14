#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

mkdir -p "${PREFIX}/etc"
cp "${RECIPE_DIR}/dirac.cfg" "${PREFIX}/etc/dirac.cfg"

# vomsdir
mkdir -p "${PREFIX}/etc/grid-security/vomsdir"
cp -r "${RECIPE_DIR}/vomsdir-lhcb/lhcb/" "${PREFIX}/etc/grid-security/vomsdir/lhcb"

# vomses
mkdir -p "${PREFIX}/etc/grid-security/vomses"
cp "${RECIPE_DIR}"/vomses-lhcb/* "${PREFIX}/etc/grid-security/vomses/"

# Environment variables, set and unset by conda/pixi on (de)activation for every shell
mkdir -p "${PREFIX}/etc/conda/env_vars.d"
cat > "${PREFIX}/etc/conda/env_vars.d/${PKG_NAME}.json" <<JSON
{
  "X509_VOMS_DIR": "${PREFIX}/etc/grid-security/vomsdir",
  "DIRACX_URL": "https://lhcbdiracx.app.cern.ch/"
}
JSON
