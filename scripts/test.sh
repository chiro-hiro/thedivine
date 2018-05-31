#!/usr/bin/env sh

ganache-cli > /dev/null 2>&1 &
ganache_pid=$!
truffle migrate
truffle test
ganache_result=$?
kill -9 $ganache_pid
exit $ganache_result