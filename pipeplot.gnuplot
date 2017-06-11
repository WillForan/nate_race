set ydata time;
set timefmt "%M:%S";
plot "< ./parse.sh 'Will Foran'" using 1:2 title 'Will Foran' with linespoints, "< ./parse.sh 'Brad Argentine'" using 1:2 title 'Brad Argentine' with linespoints
