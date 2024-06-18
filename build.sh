#!/bin/bash

# 版本打印
node -v
npm -v
set -e
. /home/tiger/.nvm/nvm.sh # 加载 SCM 机器上的 nvm 脚本
nvm install v20
nvm use v20

echo 'use pnpm'
npm i -g pnpm
pnpm -v
node -v
npm -v

export PERFSEE_TOKEN=uBO5buq//vB3/xXw8EF95jQXmzSvTVDzX1pqxs/p0Ddk=


# FE Build
pnpm install --no-frozen-lockfile

pnpm run build
mkdir -p ./output/
cp -rf ./dist/* ./output/

env