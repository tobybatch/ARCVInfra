#!/bin/bash

chmod 755 /build
cd /build
yarn install
# TODO - standardise build commands
yarn production || yarn build
