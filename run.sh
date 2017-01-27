#!/bin/bash
set +e

if [ -z "$WERCKER_APPETIZE_TOKEN" ]
then
    fail "missing token"
fi

if [ -z "$WERCKER_APPETIZE_PATH" ]
then
    fail "missing path to app"
fi

if [ -z "$WERCKER_APPETIZE_PLATFORM" ]
then
    fail "missing platform type"
fi


RES=$(curl https://$WERCKER_APPETIZE_TOKEN@api.appetize.io/v1/apps \
    -F "file=@$WERCKER_APPETIZE_PATH" \
    -F "platform=$WERCKER_APPETIZE_PLATFORM" \
    -F "note=\"revision $WERCKER_GIT_COMMIT, build url: $WERCKER_RUN_URL\"")

APPETIZE_KEY=`echo $RES | grep -Po '(?<="publicKey":")(.*?)(?=",)'`
if [[ -z $APPETIZE_KEY ]]
then
    fail "$RES"
else
    info "app is avalible at https://appetize.io/app/$APPETIZE_KEY"
    #export WERCKER_APPETIZE_APPKEY=$APPETIZE_KEY
    cat $APPETIZE_KEY > .appetize_appkey
fi
