#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"/tests/extensions/raw

if [[ "${OS:-}" == "Windows_NT" ]]; then
    # XXX: hack! on windows one needs to build twice - linker errors occur on the very first monty build
    dub build --compiler=ldc2 || true

    # only LDC supported on windows
    dub build --compiler=ldc2
    cd -

    cp "$SCRIPT_DIR"/tests/extensions/raw/raw.dll "$SCRIPT_DIR"/tests/raw.pyd
    # note: on windows the D shared libraries need to be inside the .pyd directory
    # or python code manually injecting dll paths would need to be used.
    cp $(where phobos2-ldc-shared.dll) $(where druntime-ldc-shared.dll) "$SCRIPT_DIR"/tests

    python -m pytest -s -vv tests
else
    dub build
    cd -

    cp "$SCRIPT_DIR"/tests/extensions/raw/libraw.so "$SCRIPT_DIR"/tests/raw.so

    pytest -s -vv tests
fi
