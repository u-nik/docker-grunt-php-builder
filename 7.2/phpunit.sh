#!/usr/bin/env bash

COVERAGE_ENABLED=${PHPUNIT_COVERAGE_ENABLED-true}

# Start phpunit with enabled code coverage.
if ${COVERAGE_ENABLED}; then
    # Enable xdebug for next call.
    export PHP_XDEBUG_ENABLED=true

    exec /usr/local/bin/phpunit.phar \
        --coverage-clover /reports/clover.xml \
        --log-junit /reports/phpunit.xml \
        --coverage-html /reports/coverage/html \
        $@
else
    exec /usr/local/bin/phpunit.phar $@
fi