#!/bin/gnuplot
reset
set output "figure/redis/maxmemory-policy_used_memory.eps"
set term postscript "Helvetica" eps enhance dl 2 color
set yrange[*:1]
set style data histogram
set style histogram clustered gap 1
set style fill solid 0.4 border
set ytics nomirror font ",10"
set xtics nomirror font ",10"
plot  \
    "./redis/maxmemory/maxmemory-policy_used_memory.dat" using ($2/67108864):xticlabels(1) title "Used Memory Ratio"

    
	