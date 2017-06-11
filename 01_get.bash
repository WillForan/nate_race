#!/usr/bin/env bash

[ ! -d race_results/raw ] && mkdir race_results/raw 
cd race_results/raw

for y in 0{1..9} 1{0..7}; do
 [ -n "$(find . -iname "Nate*$y*" )" ] && continue

 wget http://leonetiming.com/20$y/Roads/Nate5KGN$y.htm ||
 wget http://leonetiming.com/20$y/Roads/Nate$y.htm ||
 wget http://leonetiming.com/20$y/Roads/Nate5K$y.htm ||
 wget http://leonetiming.com/20$y/Roads/Nate$y.txt ||
 echo cannot find $y

 sleep 1
done
