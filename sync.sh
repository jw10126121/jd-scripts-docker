#!/bin/bash
trap 'cp /jd-scripts-docker/sync.sh /sync' Exit
git clone --depth=1 https://github.com/jw10126121/jd-scripts-docker.git /jd-scripts-docker_tmp
[ -d /jd-scripts-docker_tmp ] && {
  echo '复制jd-scripts-docker_tmp到jd-scripts-docker'
  rm -rf /jd-scripts-docker
  mv /jd-scripts-docker_tmp /jd-scripts-docker

   echo '取出codeKey'
  cat /jd-scripts-docker/env/codeKey > /codeKey
  echo '取出sync'
  cat /jd-scripts-docker/sync.sh > /sync
}


# git clone -b master git@gitee.com:lxk0301/jd_scripts.git /scripts_tmp
# git clone --branch=master --depth=1 https://gitee.com/lxk0301/jd_scripts.git /scripts_tmp
# [ ! -d /scripts_tmp ] && {
  # 添加KEY
  [ -e /codeKey ] && {
    echo '添加公钥'
    [ ! -d /root/.ssh ] && { mkdir -p /root/.ssh }
    cat /codeKey > /root/.ssh/id_rsa
    chmod 700 /root/.ssh/id_rsa
    ssh-keyscan gitee.com > /root/.ssh/known_hosts
    # git clone --branch=master --depth=1 git@gitee.com:lxk0301/jd_scripts.git /scripts_tmp
    git clone -b master git@gitee.com:lxk0301/jd_scripts.git /scripts_tmp
  }
# }

[ -d /scripts_tmp ] && {
  echo '覆盖新scripts'
  rm -rf /scripts
  mv /scripts_tmp /scripts
}

cd /scripts || exit 1
npm install || npm install --registry=https://registry.npm.taobao.org || exit 1
[ -e /crontab.list ] && cp /crontab.list /crontab.list.old
cp /jd-scripts-docker/crontab.list /crontab.list
crontab -r
crontab /crontab.list || {
  cp /crontab.list.old /crontab.list
  crontab /crontab.list
}
crontab -l
