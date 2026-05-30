#!/usr/bin/env  bash
#
# Author: Matt Turner <https://mat.phd>
# Date: 27 May 2026
#

set -euo pipefail

source set_env.sh

clear

envsubst < portal_art.txt 
