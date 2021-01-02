#!/bin/bash
trap 'cp /jd-scripts-docker/sync.sh /sync' Exit
git clone --depth=1 https://github.com/jw10126121/jd-scripts-docker.git /jd-scripts-docker_tmp
[ -d /jd-scripts-docker_tmp ] && {
  rm -rf /jd-scripts-docker
  mv /jd-scripts-docker_tmp /jd-scripts-docker
}
git clone --branch=master --depth=1 https://github.com/lxk0301/jd_scripts.git /scripts_tmp
[ -d /scripts_tmp ] && {
  rm -rf /scripts
  mv /scripts_tmp /scripts
}

git clone --depth=1 https://github.com/shylocks/Loon.git /jkd_scripts_tmp
[ -d /jkd_scripts_tmp ] && {
  [ -d /jkd_scripts ] && rm -rf /jkd_scripts
  mv /jkd_scripts_tmp /jkd_scripts
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
