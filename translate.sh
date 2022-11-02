#!/bin/bash

set -euo pipefail

PACKAGE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
i="$PACKAGE_DIR"/source/python/c.dpp
o="$PACKAGE_DIR"/source/python/c.d

if [[ ! -f $o || $i -nt $o ]]; then
    PYTHON_INCLUDE_PATH=$(python "$PACKAGE_DIR"/include.py)
    dub run dpp@0.4.11 --build=release --compiler=ldc2 -- --function-macros --preprocess-only --include-path "$PYTHON_INCLUDE_PATH" "$i"
fi
