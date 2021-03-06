#!/bin/gnuplot


reset
set output "figure/redis/persist10_latency.eps"
set term postscript "Helvetica" eps enhance dl 2 color

set pointsize 0.8
set size 1.0,1.0

set title "Data Size: 10 bytes"
set ylabel "Latency (Milliseconds)" font ",24"
set xlabel "Concurrent Connections" font ",24"

set ytics nomirror font ",20"
set xtics nomirror font ",20"

set mxtics 2
#set logscale y
set key top left
set key samplen 1.8 spacing 1 width 1 height 0.5 font ",20" maxrows 5
set xrange[1:*]

plot  \
	"./redis/persist/Throughput_set_persist10_latency.dat" u 1:($2) title "With Persistence" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#FF7F00', \
	"./redis/persist/Throughput_set_nopersist10_latency.dat" u 1:($2) title "No Persistence" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#C0FF3E'