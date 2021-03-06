#!/bin/bash

echo Linux Docker build Docker

project_name="Shop.WebApi"
port=6101
image_name="shop_dev"
image_version="1.0.0"

# image version
echo $image_version;

cd /home/docker/images

# 如果已经存在解压包
rm -rf publish

unzip $project_name.zip

cd publish

# 覆盖环境配置文件
/bin/cp -rf /home/config/shop/appsettings.Development.json appsettings.json

# stop container
docker stop $image_name

# remove container
docker rm $image_name

# remove image
docker rmi $image_name:$image_version

# build image tag
docker build -t $image_name:$image_version .

# run
docker run -p $port:80 --restart=always --name $image_name --volume /home/shop_dev/wwwroot/user-content:/app/wwwroot/user-content/ -d $image_name:$image_version
docker logs $image_name

cd /home/docker/images

rm -f $project_name.zip
rm -f build_docker.sh
rm -rf publish