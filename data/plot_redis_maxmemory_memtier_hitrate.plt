#!/bin/gnuplot


reset
set output "figure/redis/maxpolicy_memtier_hitrate.eps"
set term postscript "Helvetica" eps enhance dl 2 color

set pointsize 0.8
set size 1.0,1.0

set title "Hit Rate under Memtier-benchmark"
set ylabel "Hit Rate (%)" font ",24"
set xlabel "Time (s)" font ",24"

set ytics nomirror font ",20"
set xtics nomirror font ",20"

set mxtics 2
#set logscale y
set key top left
set key samplen 1.8 spacing 1 width 1 height 0.5 font ",20" maxrows 5
set xrange[1:*]


plot  \
	"./redis/redis_hitrate/allkeys-lfu.dat" u 1:(100*$5/($7+$5)) title "allkeys-lfu" w lp lt 3 lw 3 pt 7 ps 0 lc rgb '#EEB422', \
	"./redis/redis_hitrate/allkeys-lru.dat" u 1:(100*$5/($7+$5)) title "allkeys-lru" w lp lt 3 lw 3 pt 7 ps 0 lc rgb '#FF7F00', \
    "./redis/redis_hitrate/allkeys-random.dat" u 1:(100*$5/($7+$5)) title "allkeys-random" w lp lt 3 lw 3 pt 7 ps 0 lc rgb '#EEEE00', \
	"./redis/redis_hitrate/volatile-lfu.dat" u 1:(100*$5/($7+$5)) title "volatile-lfu" w lp lt 3 lw 3 pt 7 ps 0 lc rgb '#C0FF3E', \
	"./redis/redis_hitrate/volatile-lru.dat" u 1:(100*$5/($7+$5)) title "volatile-lru" w lp lt 3 lw 3 pt 7 ps 0 lc rgb '#6495ED', \
	"./redis/redis_hitrate/volatile-ttl.dat" u 1:(100*$5/($7+$5)) title "volatile-ttl" w lp lt 3 lw 3 pt 7 ps 0 lc rgb '#4B0082', \
    "./redis/redis_hitrate/volatile-random.dat" u 1:(100*$5/($7+$5)) title "volatile-random" w lp lt 3 lw 3 pt 7 ps 0 lc rgb '#CD3333'
