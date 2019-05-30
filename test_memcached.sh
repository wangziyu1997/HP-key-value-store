#!/bin/sh
#/usr/local/tool/memcached-1.5.14/memcached -d -l 127.0.0.1 -p 11211 -u root -m 64 -c 1024 -P /var/run/memcached.pid
#1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63
#threads,maxconns,chunk_size,growth_factor,-C,-L
#maxmemory_policy,maxmemory,RDB,AOF,maxclients

cd ./plot_data
rm memcached.dat
touch memcached.dat
cd ..

echo "1 Concurrent Connections-Throughput 关系图" >> ./plot_data/memcached.dat
for i in 1 2 3 4 10 20 30 40 50 60;
do
    echo "Thread　number: $i" >> ./plot_data/memcached.dat

    for j in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
        do
            # echo $i
            # echo $j
            num_calls=$((100000/$j))
            echo -n $j >> ./plot_data/memcached.dat
            ../tool/memcached-1.5.14/memcached -d -m 1024 -u root -p 11211 -P /tmp/memcached.pid -t $i
            sleep 1s
            ../tool/twemperf/src/mcperf --num-conns=$j --conn-rate=1000000 --num-calls=$num_calls --sizes=100 --method=set --port=11211 
            sleep 5s
            kill `cat /tmp/memcached.pid`
            sleep 1s
        done
done

echo "2 Throughput-Latency 关系图" >> ./plot_data/memcached.dat
for i in 1 2 3 4 10 20 30 40 50 60;
do
    echo "Thread　number: $i" >> ./plot_data/memcached.dat

    for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
        do
            # echo $i
            # echo $j
            call_rate=$(($j*100))
            ../tool/memcached-1.5.14/memcached -d -m 1024 -u root -p 11211 -P /tmp/memcached.pid -t $i
            sleep 1s
            ../tool/twemperf/src/mcperf --num-conns=100 --conn-rate=10000 --num-calls=100 --call-rate=$call_rate --sizes=100 --method=get --port=11211 
            sleep 5s
            kill `cat /tmp/memcached.pid`
            sleep 1s
        done
done

# echo "4. Memory utilization 柱状图" >> ./plot_data/memcached.dat
# echo "3.3 chunk_size+growth_factor" >> ./plot_data/memcached.dat
# for i in 1 2 3 4 10 20 30 40;
# do
#     echo "Thread　number: $i" >> ./plot_data/memcached.dat

#     for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
#         do
#             # echo $i
#             # echo $j
#             call_rate=$(($j*100))
#             ../tool/memcached-1.5.14/memcached -d -m 1024 -u root -p 11211 -P /tmp/memcached.pid -t $i
#             sleep 1s
#             ../tool/twemperf/src/mcperf --linger=0 --timeout=5 --num-conns=100 --conn-rate=10000 --num-calls=1000 --call-rate=$call_rate --sizes=u10,1024 --method=get --port=11211 
#             sleep 20s
#             kill `cat /tmp/memcached.pid`
#             sleep 1s
#         done
# done

# echo "3. memcached钙化问题" >> ./plot_data/memcached.dat
# ../tool/memcached-1.5.14/memcached -d -u root -p 11211 -P /tmp/memcached.pid -o slab_reassign,slab_automove
# ../tool/twemperf/src/mcperf --num-conns=100 --conn-rate=1000 --sizes=0.01 --num-calls=10000
# ../tool/twemperf/src/mcperf --num-conns=100 --conn-rate=1000 --sizes=0.001 --num-calls=1000
# ../tool/twemperf/src/mcperf --num-conns=100 --conn-rate=1000 --sizes=0.0001 --num-calls=100
# ../tool/twemperf/src/mcperf --num-conns=100 --conn-rate=1000 --sizes=0.00001 --num-calls=10
# ../tool/memcached-1.5.14/scripts/memcached-tool localhost:11211
# kill `cat /tmp/memcached.pid`


