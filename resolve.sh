#!/bin/bash
[ -n "$FruitShareCodes" ] && {
  FRUITSHARECODES="$FruitShareCodes"
}
[ -n "$PetShareCodes" ] && {
  PETSHARECODES="$PetShareCodes"
}
[ -n "$SuperMarketShareCodes" ] && {
  SUPERMARKET_SHARECODES="$SuperMarketShareCodes"
}
[ "$FRUITSHARECODES" == "" ] && {
FRUITSHARECODES=""
}
[ "$PETSHARECODES" == "" ] && {
PETSHARECODES=""
}
[ "$PLANT_BEAN_SHARECODES" == "" ] && {
PLANT_BEAN_SHARECODES=""
}
[ "$SUPERMARKET_SHARECODES" == "" ] && {
SUPERMARKET_SHARECODES=""
}
FruitShareCodes=$FRUITSHARECODES
jdJoyRewardNotify=$JD_JOY_REWARD_NOTIFY
jdSuperMarketRewardNotify=$MARKET_REWARD_NOTIFY
joyRunFlag=$JOY_RUN_FLAG
jdSuperMarketUpgrade=$SUPERMARKET_UPGRADE
jdBusinessCircleJump=$BUSINESS_CIRCLE_JUMP
jdSuperMarketLottery=$SUPERMARKET_LOTTERY
jdFruitBeanCard=$FRUIT_BEAN_CARD
