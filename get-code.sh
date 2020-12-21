code1=
code2=
code3=
code4=
code5=
code6=
for srv in $(docker-compose config --services);do
  CMD="docker logs $srv 2>/dev/null"
  line="$(eval $CMD | egrep -A1 '您的.*(邀请码|互助码|助力码).*' | grep -v '^--$' | sed -r "s/[[:cntrl:]]\[[0-9]{1,3}m//g" | sed 'N;s/\n/ /' | sort -u )"
  [ -z "$code1" ] || code1+=@
  [ -z "$code2" ] || code2+=@
  [ -z "$code3" ] || code3+=@
  [ -z "$code4" ] || code4+=@
  [ -z "$code5" ] || code5+=@
  [ -z "$code6" ] || code6+=@
  code1+=$(echo "$line" | grep "东东农场" | head -n 1 | grep -Eo '[a-zA-Z0-9_=+/]{15,}')
  code2+=$(echo "$line" | grep "东东萌宠" | head -n 1 | grep -Eo '[a-zA-Z0-9_=+/]{15,}')
  code3+=$(echo "$line" | grep "种豆得豆" | head -n 1 | grep -Eo '[a-zA-Z0-9_=+/]{15,}')
  code4+=$(echo "$line" | egrep "京小超|东东超市" | head -n 1 | grep -Eo '[a-zA-Z0-9_=+/]{15,}')
  code5+=$(echo "$line" | grep "京东赚赚" | head -n 1 | grep -Eo '[a-zA-Z0-9_=+/]{15,}')
  code6+=$(echo "$line" | grep "健康抽奖机" | head -n 1 | grep -Eo '[a-zA-Z0-9_=+/]{15,}')
done
echo FRUITSHARECODES=$code1
echo PETSHARECODES=$code2
echo PLANT_BEAN_SHARECODES=$code3
echo SUPERMARKET_SHARECODES=$code4
echo JDZZ_SHARECODES=$code5
echo JDHealth_SHARECODES=$code6