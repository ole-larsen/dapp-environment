Create separate images from one Dockerfile:

main image based on node:alpine and contains ganache, truffle and hardhat
You can change prefix olelarsen/ to whatever to build your own images.
Do not forget to change docker-compose.yml

TODO: 
write makefile to use own build names
# get images:
````
docker pull olelarsen/ganache
docker pull olelarsen/truffle
docker pull olelarsen/hardhat
````

# build:
````
docker build  --target=ganache -t olelarsen/ganache .
docker build  --target=truffle -t olelarsen/truffle .
docker build  --target=hardhat -t olelarsen/hardhat .
````

# run:
````
docker-compose up -d --build
````
# run separate:
````
docker run olelarsen/ganache
docker run olelarsen/truffle
docker run olelarsen/hardhat
````