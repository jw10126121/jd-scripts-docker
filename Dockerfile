FROM ubuntu:20.04
ENV DEBIAN_FRONTEND="noninteractive"
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
    sed -Ei 's/security.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list; \
    sed -Ei 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list;

RUN date

RUN apt update && apt install -y cron openssl coreutils git wget tzdata
RUN apt update && apt install -y nodejs
RUN apt update && apt install -y npm
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata
WORKDIR /
COPY sync.sh /sync.sh
RUN bash /sync.sh
CMD crontab -l && cron -f
