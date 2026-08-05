#!/bin/bash

# Added by m8jj
git pull
pnpm i && pnpm build
service wstd restart
echo "\nWSTD Updated!";