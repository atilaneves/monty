# This makefile is unfortunately required for multiple reasons:
# * dub doesn't let us set variables and use them
# * we need to set variables because we need to know where Python is installed
# * we need to know where Python is installed to find the headers for dpp and
#   to find the Python library path to pass -L to the linker.
# * although we can run dpp and get the python D translations from dub using
#   "preGenerateCommands", it runs every single time.

all: test-raw

export PYTHON_INCLUDE_DIR = $(shell python -c "from sysconfig import get_paths as gp; print(gp()['include'])")
# Only needed when linking to python to use as a library (e.g. unittests)
# export PYTHON_LIB_DIR = $(shell python -c "from sysconfig import get_config_var; print(get_config_var('LIBDIR'))")
# export PYTHON_LIB = $(shell python -c "from sys import version_info as vi; print(f'python{vi.major}.{vi.minor}')")


# this is here to be used by dub in preGenerateCommands and shouldn't
# be referenced explicitly in this Makefile
source/python/c.d: source/python/c.dpp $(PYTHON_INCLUDE_DIR)/Python.h
	dub run dpp@0.4.11 -q --build=release -- --function-macros --preprocess-only --include-path $(PYTHON_INCLUDE_DIR) $<

.PHONY: test-raw
test-raw: tests/extensions/raw/libraw.so
	PYTHONPATH=$(shell pwd)/tests/extensions/raw pytest -s -vv tests

.PHONY: tests/extensions/raw/libraw.so
tests/extensions/raw/libraw.so:
	cd tests/extensions/raw && dub build -q
