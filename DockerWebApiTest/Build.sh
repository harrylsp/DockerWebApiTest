#!/bin/bash

echo clear none docker image
# 停止容器
docker stop $(docker ps -a | grep "Exited" | awk '{print $1}')
# 删除容器
docker rm $(docker ps -a | grep "Exited" | awk '{print $1}')
# 删除镜像
docker rmi $(docker images | grep "none" | awk '{print $3}')
echo clear success

echo Linux Docker build
# 构建命令要要指定的 Dockerfile 文件所在
# 下面的命令是指 Dockerfile 在当前目录找
docker build -t dockerwebapitest .
echo docker build success

echo stop container

docker container stop dockerwebapitest

echo stop container success

echo remove container

docker container rm dockerwebapitest

echo remove container success

echo docker run

# -d 后台运行
# -p 8888:80 生成一个外部8888端口，对应容器的80端口 也就是Dockerfile 暴露的端口 EXPOSE 80
# --restart=always 开机自动启动容器 无论退出状态是如何，都重启容器
docker run -d --restart=always --name="dockerwebapitest" -p 8888:80 dockerwebapitest

echo docker run success