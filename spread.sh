#!/bin/bash

echo Starting spreading configs...

PWD=`pwd`
while read TARGET; do
    SOURCE=`echo $TARGET | sed "s,~,$PWD,g"`
    DESTINATION=`echo $TARGET | sed "s,~,$HOME,g"`
    DESTINATION=`dirname $DESTINATION`
    mkdir -p $DESTINATION
    echo $TARGET
    cp $SOURCE $DESTINATION
done < ./list

echo Done.
