#!/bin/bash
trap 'cp /jd-scripts-docker/sync.sh /sync' Exit
git clone --depth=1 https://github.com/jw10126121/jd-scripts-docker.git /jd-scripts-docker_tmp
[[ -d /jd-scripts-docker_tmp ]] && {
  echo '更新jd-scripts-docker'
  [[ -d /jd-scripts-docker ]] && rm -rf /jd-scripts-docker
  mv /jd-scripts-docker_tmp /jd-scripts-docker
  [[ -e /codeKey ]] && rm -fr /codeKey
  
  [[ -e /jd-scripts-docker/env/sshCodeKey ]] && {
    echo '复制/jd-scripts-docker/env/codeKey'
    cat /jd-scripts-docker/env/sshCodeKey > /codeKey
  }
  
  [[ ! -e /jd-scripts-docker/env/sshCodeKey ]] && {
    [[ -e /sshCodeKey ]] && {
      echo '复制/sshCodeKey'
      cat /sshCodeKey > /codeKey
    }

    [[ ! -e /sshCodeKey ]] && {
      [[ -e /sshCodeKey_first ]] && {
        echo '复制/sshCodeKey_first'
        cat /sshCodeKey_first > /codeKey
      }
    }

  }

}


# git clone -b master git@gitee.com:lxk0301/jd_scripts.git /scripts_tmp
# git clone --branch=master --depth=1 https://gitee.com/lxk0301/jd_scripts.git /scripts_tmp
  # 添加KEY
  [[ -e /codeKey ]] && {
    echo '添加公钥'
    cat /codeKey
    [[ ! -d /root/.ssh ]] && mkdir -p /root/.ssh
    cat /codeKey > /root/.ssh/id_rsa
    chmod 700 /root/.ssh/id_rsa
    ssh-keyscan gitee.com > /root/.ssh/known_hosts
    cd /
    git clone --branch=master --depth=1 git@gitee.com:lxk0301/jd_scripts.git /scripts_tmp
  }

[[ ! -d /scripts_tmp ]] && {
  echo '更新失败，下载scripts失败'
}

[[ -d /scripts_tmp ]] && {
  echo '更新成功，覆盖新scripts'
  [[ -d /scripts ]] && rm -rf /scripts
  mv /scripts_tmp /scripts
}




# cui521脚本
# git clone --depth=1 https://github.com/cui521/jdqd.git /jdqd_tmp
# [[ -d /jdqd_tmp ]] && {
#   [[ -d /jdqd ]] && rm -rf /jdqd
#   mv /jdqd_tmp /jdqd
#   cp /jdqd/DIY_shopsign.js /scripts/DIY_shopsign.js
# }

# shuye
git clone --depth=1 https://gitee.com/shuye72/MyActions.git /shuye_tmp
[[ -d /shuye_tmp ]] && {
  [[ -d /shuye ]] && rm -rf /shuye
  mv /shuye_tmp /shuye
  cp /shuye/jd_ShopSign.js /scripts/jd_ShopSign.js
}

cd /scripts || exit 1
wget https://share.r2ray.com/dust/car/monk_shop_add_to_car.js
wget https://share.r2ray.com/dust/car/monk_skyworth_car.js
wget https://share.r2ray.com/dust/i-chenzhe/z_entertainment.js
wget https://share.r2ray.com/dust/i-chenzhe/z_fanslove.js
wget https://share.r2ray.com/dust/i-chenzhe/z_marketLottery.js
wget https://share.r2ray.com/dust/i-chenzhe/z_mother_jump.js
wget https://share.r2ray.com/dust/i-chenzhe/z_shake.js
wget https://share.r2ray.com/dust/i-chenzhe/z_super5g.js
wget https://share.r2ray.com/dust/i-chenzhe/z_xmf.js
wget https://share.r2ray.com/dust/member/monk_pasture.js
wget https://share.r2ray.com/dust/member/monk_vinda.js
wget https://share.r2ray.com/dust/normal/monk_inter_shop_sign.js
wget https://share.r2ray.com/dust/normal/monk_shop_follow_sku.js
wget https://share.r2ray.com/dust/normal/monk_shop_lottery.js


cd /scripts || exit 1

npm install || npm install --registry=https://registry.npm.taobao.org || exit 1

# 备份crontab.list
[[ -e /crontab.list ]] && mv /crontab.list /crontab.list.old

echo '更新crontab'
cp /jd-scripts-docker/crontab.list /crontab.list
crontab -r
crontab /crontab.list || {
  cp /crontab.list.old /crontab.list
  crontab /crontab.list
}
crontab -l
