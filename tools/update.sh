#!/usr/bin/env bash

: ${SCRIPT:=https://raw.githubusercontent.com/alexmanno/effix/master/tools/install.sh}

sh -c "$(curl -fsSL $SCRIPT)"
