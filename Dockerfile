# Node image
FROM node:alpine as build

# Maintainer
MAINTAINER Ole Larssen <ole.larssen777@gmail.com>

# Install container dependencies
RUN apk add --update --no-cache nodejs npm build-base python3 py3-pip

RUN npm install -g ganache truffle hardhat

FROM build as ganache
EXPOSE 8545
ENTRYPOINT ["ganache"]

FROM build as truffle

WORKDIR /truffle
# Startup script
RUN printf "%s\n" "#!/bin/sh" "set -e" "if [ ! -f truffle-config.js ]; then" "  truffle init" "fi" "exec truffle-entrypoint" > truffle-entrypoint.sh && mv truffle-entrypoint.sh /usr/local/bin/truffle-entrypoint
RUN chmod +x /usr/local/bin/truffle-entrypoint

ENTRYPOINT ["truffle-entrypoint"]

FROM build as hardhat

WORKDIR /hardhat
# Startup script
RUN printf "%s\n" "#!/bin/sh" "set -e" "if [ ! -f hardhat-config.js ]; then" "  hardhat init" "fi" "exec hardhat-entrypoint" > hardhat-entrypoint.sh && mv hardhat-entrypoint.sh /usr/local/bin/hardhat-entrypoint
RUN chmod +x /usr/local/bin/hardhat-entrypoint

ENTRYPOINT ["hardhat-entrypoint"]