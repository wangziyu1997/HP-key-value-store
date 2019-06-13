#!/bin/gnuplot


reset
set output "figure/set_throughput_compare_memtier.eps"
set term postscript "Helvetica" eps enhance dl 2 color

set pointsize 0.8
set size 1.0,1.0


set ylabel "Throughput (rsp/s)" font ",24"
set xlabel "Threads Number" font ",24"

set ytics nomirror font ",20"
set xtics nomirror font ",20"

set mxtics 2
set yrange[0:*]
set key top left
set key samplen 1.8 spacing 1 width 1 height 0.5 font ",20" maxrows 5


plot  \
	"./compare/compare_redis.dat" u 2:4 title "Redis" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#FF7F00', \
	"./compare/compare_memcached.dat" u 2:4 title "Memcached" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#C0FF3E'