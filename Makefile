all: test-raw

PYTHON_INCLUDE_DIR = $(shell python -c "from sysconfig import get_paths as gp; print(gp()['include'])")

source/python/c.d: source/python/c.dpp
	dub run dpp@0.4.9 --build=release --compiler=ldc2 -- --preprocess-only --include-path $(PYTHON_INCLUDE_DIR) $<

.PHONY: test-raw
test-raw: source/python/c.d tests/extensions/raw/raw.so
	PYTHONPATH=$(shell pwd)/tests/extensions/raw pytest -s -vv tests

tests/extensions/raw/raw.so: tests/extensions/raw/libraw.so
	cp $< $@

.PHONY: tests/extensions/raw/libraw.so
tests/extensions/raw/libraw.so:
	cd tests/extensions/raw && dub build
