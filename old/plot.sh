#!/bin/bash
#use: ./plot.sh|gnuplot -persit - 
#or (echo "set term png; set output 'plot.png'"; ./plot.sh;)|gnuplot

cat <<EOD
set term png
set output "plot.png"
set ydata time;
set timefmt "%M:%S";
set key outside bottom;
set yrange ["16:00":"30:00"]
EOD
echo -n 'plot'
for name in \
    'Patrick Foran'\
    'Rachel Elder'\
    'Steve Fie' \
    'Michael Rice' \
    'Erick Wells' \
    'Kayla Curtis' \
     'Katherine Foran' \
     'Sarah Foran'\
     'Rosemary Foran'\
    'Meredith Kelly'\
     'Will Foran'\
     'Zachery Szkolnik'\
    'Rob Argentine'\
    'Jonathan Williams'\
    'Joseph Kopnitsky'\
     'Brad Frink'\
     'Aaron Walker'\
     'Brad Argentine'\
    ; do
    echo -n " \"< ./parse.sh '$name'\" using 1:2 title '$name' with linespoints,"
done | sed 's/,$//g'
#echo ""
