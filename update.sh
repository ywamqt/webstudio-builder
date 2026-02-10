#!/bin/bash

git pull
pnpm i && pnpm build
cd .devcontainer && docker compose up -d
cd .. && pnpm migrations migrate
service wstd restart
echo "\nWSTD Updated!";
#hi