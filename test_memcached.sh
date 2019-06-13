#!/bin/sh
#STAT limit_maxbytes 67108864

cd ./plot_data
rm memcached.dat
rm memtop.dat
touch memcached.dat
touch memtop.dat
cd ..

echo "1 Concurrent Connections-Throughput 关系图 set" >> ./plot_data/memcached.dat
for i in 1 2 3 4 10 20 30 40 50 60;
do
    echo "Thread　number: $i" >> ./plot_data/memcached.dat

    for j in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
        do
            # echo $i
            # echo $j
            num_calls=$((500000/$j))
            echo -n $j >> ./plot_data/memcached.dat
            ../tool/memcached-1.5.14/memcached -d -m 1024 -u root -p 11211 -P /tmp/memcached.pid -t $i
            sleep 1s
            nohup ../tool/twemperf/src/mcperf --num-conns=$j --conn-rate=1000000 --num-calls=$num_calls --sizes=100 --method=set --port=11211 &
            top -b -n 15 | grep 'memcached'>> ./plot_data/memtop.dat
            kill `cat /tmp/memcached.pid`
            sleep 1s
        done
done

echo "1 Concurrent Connections-Throughput 关系图 get" >> ./plot_data/memcached.dat
for i in 1 2 3 4 10 20 30 40 50 60;
do
    echo "Thread　number: $i" >> ./plot_data/memcached.dat

    for j in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
        do
            # echo $i
            # echo $j
            num_calls=$((500000/$j))
            echo -n $j >> ./plot_data/memcached.dat
            ../tool/memcached-1.5.14/memcached -d -m 1024 -u root -p 11211 -P /tmp/memcached.pid -t $i
            sleep 1s
            nohup ../tool/twemperf/src/mcperf --num-conns=$j --conn-rate=1000000 --num-calls=$num_calls --sizes=100 --method=get --port=11211 &
            top -b -n 15 | grep 'memcached'>> ./plot_data/memtop.dat
            kill `cat /tmp/memcached.pid`
            sleep 1s
        done
done

echo "2 Throughput-Latency 关系图 set" >> ./plot_data/memcached.dat
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
            nohup ../tool/twemperf/src/mcperf --num-conns=100 --conn-rate=10000 --num-calls=5000 --call-rate=$call_rate --sizes=100 --method=set --port=11211 &
            top -b -n 15 | grep 'memcached'>> ./plot_data/memtop.dat
            kill `cat /tmp/memcached.pid`
            sleep 1s
        done
done

echo "2 Throughput-Latency 关系图 get" >> ./plot_data/memcached.dat
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
            nohup ../tool/twemperf/src/mcperf --num-conns=100 --conn-rate=10000 --num-calls=5000 --call-rate=$call_rate --sizes=100 --method=get --port=11211 &
            top -b -n 15 | grep 'memcached'>> ./plot_data/memtop.dat
            kill `cat /tmp/memcached.pid`
            sleep 1s
        done
done

# cd ./plot_data
# rm growth_factor.dat
# touch growth_factor.dat
# cd ..

# echo "3.3 chunk_size+growth_factor" >> ./plot_data/growth_factor.dat
# for i in 100 1000 10000 100000;
# do
#     echo "Thread　number: $i" >> ./plot_data/growth_factor.dat

#     for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
#         do
#             # echo $i
#             # echo $j
#             growth_factor=$(expr "scale=2;1 + 0.05*$j"|bc)
#             echo "u1,$i growth_factor $growth_factor" >> ./plot_data/growth_factor.dat
#             ../tool/memcached-1.5.14/memcached -d -m 64 -u root -p 11211 -P /tmp/memcached.pid -f $growth_factor
#             sleep 1s
#             ../tool/twemperf/src/mcperf --num-conns=100 --num-calls=10000 --sizes=u1,$i --method=set --port=11211 
#             sleep 40s
#             # printf "stats\r\n" | nc localhost 11211 | grep -E " evictions | bytes | limit_maxbytes " >> ./plot_data/growth_factor.dat
#             printf "stats\r\n" | nc -w 1 localhost 11211 >> ./plot_data/growth_factor.dat 2>&1
#             sleep 1s
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


