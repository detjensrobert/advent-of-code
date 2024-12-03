#!/bin/bash

set -eux

if [ -z "$1" ] ; then
  echo "usage: $0 <day>"
  exit 1
fi


DAY=$(printf '%02d' $1)
DIR=day$DAY

mkdir $DIR

(
  cd $DIR
  aoc download --day $DAY
  touch test
)
