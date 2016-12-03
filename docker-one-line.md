## Stop and remove containers

* docker stop \`docker ps -a | grep "hours ago" | awk '{print $1}'\`
* docker rm \`docker ps -a | grep "hours ago" | awk '{print $1}'\`

## Remove images

docker rmi \`docker images | grep '<none>' | awk '{print $3}'\`
