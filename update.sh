#!/bin/bash

git pull
pnpm i && pnpm build
service wstd restart
echo "\nWSTD Updated!";
