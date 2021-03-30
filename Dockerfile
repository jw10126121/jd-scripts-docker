FROM alpine:3.12
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache curl bash openssh tzdata moreutils git nodejs npm openssl wget coreutils
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

#FROM ubuntu:20.04
#ENV DEBIAN_FRONTEND="noninteractive"
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
#    sed -Ei 's/security.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list; \
#    sed -Ei 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list;
#
#RUN apt update && apt install -y cron openssl coreutils git wget tzdata
#RUN apt update && apt install -y nodejs
#RUN apt update && apt install -y npm
#RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#RUN dpkg-reconfigure -f noninteractive tzdata

RUN date

RUN mkdir -p /root/.ssh

WORKDIR /
COPY sync.sh /sync.sh
RUN bash /sync.sh
CMD crontab -l && cron -f
