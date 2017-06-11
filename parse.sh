#!/usr/bin/env bash

for f in Nate*txt; do 
    echo -n "$(basename $f .txt) "|sed 's/Nate/20/' ;
    grep "$1" -i $f | perl -ne 'm/\d+:\d+/; print $&,"\n";';
    echo; 
done | 
grep -v '^$' #|
#xclip -selection CLIPBOARD
