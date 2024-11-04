# Variables
DEFAULT_CONFIGURATION ?= release
LOG_LEVEL = debug

# Default Target
all: release debug release_executable debug_executable release-executable debug-executable

# Build Steps
release:
	ncc build --config=release --log-level $(LOG_LEVEL)
debug:
	ncc build --config=debug --log-level $(LOG_LEVEL)
release_executable:
	ncc build --config=release_executable --log-level $(LOG_LEVEL)
debug_executable:
	ncc build --config=debug_executable --log-level $(LOG_LEVEL)
release-executable:
	ncc build --config=release-executable --log-level $(LOG_LEVEL)
debug-executable:
	ncc build --config=debug-executable --log-level $(LOG_LEVEL)


install: release
	ncc package install --package=build/release/net.nosial.socialbox_telegram.ncc --skip-dependencies --build-source --reinstall -y --log-level $(LOG_LEVEL)

test: release
	[ -f phpunit.xml ] || { echo "phpunit.xml not found"; exit 1; }
	phpunit

clean:
	rm -rf build

.PHONY: all install test clean release debug release_executable debug_executable release-executable debug-executable