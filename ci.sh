#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd tests/extensions/raw
if [[ "$OS" == "Windows_NT" ]]; then
    # only LDC supported on windows
    dub build --compiler=ldc2
    cd -

    cp tests/extensions/raw/raw.dll tests/raw.pyd
    # note: on windows the D shared libraries need to be inside the .pyd directory
    # or python code manually injecting dll paths would need to be used.
    cp $(where phobos2-ldc-shared.dll) $(where druntime-ldc-shared.dll) tests

    py -m pytest -s -vv tests
else
    dub build
    cd -

    cp tests/extensions/raw/libraw.so tests/raw.so

    pytest -s -vv tests
fi
