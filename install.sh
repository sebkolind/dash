#!/bin/bash
set -e

INSTALL_DIR="${HOME}/.local/bin"
mkdir -p "$INSTALL_DIR"
curl -fsSL https://raw.githubusercontent.com/sebkolind/dash/main/bin/dash -o "${INSTALL_DIR}/dash"
chmod +x "${INSTALL_DIR}/dash"
echo "Installed to ${INSTALL_DIR}/dash"
