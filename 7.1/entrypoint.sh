#!/usr/bin/env bash

if [ ! -d "node_modules" ]; then
    echo "Running npm install..."
    npm install
fi

grunt "$@"