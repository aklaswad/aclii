RET=0
npm run test:node || RET=1
npm run test:bash || RET=1
exit $RET
