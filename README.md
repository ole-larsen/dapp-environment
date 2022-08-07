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

# build your own!:
````
docker build  --target=ganache -t ganache .
docker build  --target=truffle -t truffle .
docker build  --target=hardhat -t hardhat .

docker-compose -f docker-compose.own.yml up -d --build
````
# Aliases (add flag -d to alias string to run in background)
````
docker network create --driver bridge web
echo >>
"
alias ganache='docker run --rm -it --name=ganache --network=web -m 128M --memory-swap -1 --user $(id -u):$(id -g) -e GOPATH=$(go env GOPATH):/go -v $HOME:$HOME -v $(pwd)/source/ganache:/ganache:rw -p 8545:8545  -w $(pwd) olelarsen/ganache' \
alias hardhat='docker run --rm -it --name=hardhat --network=web -m 128M --memory-swap -1 --user $(id -u):$(id -g) -e GOPATH=$(go env GOPATH):/go -v $HOME:$HOME -v $(pwd)/source/hardhat:/hardhat:rw -w $(pwd) olelarsen/hardhat' \
alias truffle='docker run --rm -it --name=truffle --network=web -m 128M --memory-swap -1 --user $(id -u):$(id -g) -e GOPATH=$(go env GOPATH):/go -v $HOME:$HOME -v $(pwd)/source/truffle:/truffle:rw -p 3000:3000 -w $(pwd) olelarsen/truffle'
"
~/.bash_profile