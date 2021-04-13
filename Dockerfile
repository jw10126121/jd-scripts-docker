FROM alpine:3.12
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache curl bash openssh tzdata moreutils git nodejs npm openssl wget coreutils
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

RUN date

RUN mkdir -p /root/.ssh

WORKDIR /
COPY env/sshCodeKey /sshCodeKey_first
COPY sync.sh /sync.sh
RUN bash /sync.sh
CMD crontab -l && crond -f
