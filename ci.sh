#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd tests/extensions/raw
dub build -q
cd -
cp tests/extensions/raw/libraw.so tests/raw.so
pytest -s -vv tests
