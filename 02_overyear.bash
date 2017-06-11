#!/usr/bin/env bash

# only care about year, person, and time
# so we dont have to worry about how results format change accross years
# just grab a name and a time.
# - lower case name for consitancy
# - take the largets time (mm:ss) in the line (sometimes pace is first, sometimes not)
# do this for both the new and old and only save unique year+person+time rows

[ ! -d txt ] && mkdir txt
for f in race_results/{raw,txt}/*; do 
  year=${f//[A-Za-z.]/}
  year=${year:(-2)}
  perl -lne '
    if( m/ (([-A-Za-z.'"'"']+ )+) .* (\d+):(\d+)/){
      $p=lc($1);
      $p=~s/[-.'"'"']//g;
      $m=0;$t="NA";
      while( m/ (\d+):(\d+) /g){ if($1 > $m) {$m=$1; $t="$1:$2" }  }
      print "$p\t$t";
    } 
    ' $f |
    sed "s:^:$year\t:"
done| sort |uniq > txt/year_person.txt

# whos run how many times
# cut -f 2 txt/year_person.txt|sort |uniq -c |sort -nr| head
