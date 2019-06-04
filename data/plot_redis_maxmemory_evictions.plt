#!/bin/gnuplot
reset
set output "figure/redis/maxmemory-policy_evictions.eps"
set term postscript "Helvetica" eps enhance dl 2 color
set yrange[*:2000000]
set style data histogram
set style histogram clustered gap 1
set style fill pattern 4 border -1
set ytics nomirror font ",10"
set xtics nomirror font ",10"
plot  \
    "./redis/maxmemory/maxmemory-policy_evicted_keys.dat" using ($2):xticlabels(1) title "Evicted Keys"

    
	