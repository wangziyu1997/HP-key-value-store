#!/bin/sh
#../tool/redis-5.0.5/redis-server -d -l 127.0.0.1 -p 11211 -u root -m 64 -c 1024 -P /var/run/redis.pid
#1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63
#threads,maxconns,chunk_size,growth_factor,lru_maintatiner_thread,lru_segmented,tmp_lru,-C,-L
#maxmemory－policy,maxmemory,maxclients, timeout, tcp-keepalive, save(注释掉), appendfsync(11 10 01 00)

cd ./plot_data
rm redis.dat
touch redis.dat
cd ..

echo "1. Concurrent Connections-Throughput 关系图" >> ./plot_data/memcached.dat
echo "1.1 maxclients" >> ./plot_data/memcached.dat
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo "maxclients: $i" >> ./plot_data/redis.dat

    for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
        do
            # echo $i
            # echo $j
            maxclients=$(($i*1000))
            ../tool/redis-5.0.5/redis-server 
            sleep 1s
            sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
            old_maxclients=$maxclients
            ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
            sleep 20s
            kill `cat /tmp/redis.pid`
            sleep 1s
        done
done


echo "1.2 maxclients+timeout+tcp-keepalive" >> ./plot_data/memcached.dat
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo "maxclients: $i" >> ./plot_data/redis.dat

    for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
        do
            # echo $i
            # echo $j
            maxclients=$(($i*1000))
            ../tool/redis-5.0.5/redis-server 
            sleep 1s
            sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
            old_maxclients=$maxclients
            ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
            sleep 20s
            kill `cat /tmp/redis.pid`
            sleep 1s
        done
done


echo "1.3 maxmemory-policy" >> ./plot_data/memcached.dat
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo "maxclients: $i" >> ./plot_data/redis.dat

    for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
        do
            # echo $i
            # echo $j
            maxclients=$(($i*1000))
            ../tool/redis-5.0.5/redis-server 
            sleep 1s
            sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
            old_maxclients=$maxclients
            ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
            sleep 20s
            kill `cat /tmp/redis.pid`
            sleep 1s
        done
done


echo "1.4 RDB AOF" >> ./plot_data/memcached.dat
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo "maxclients: $i" >> ./plot_data/redis.dat

    for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
        do
            # echo $i
            # echo $j
            maxclients=$(($i*1000))
            ../tool/redis-5.0.5/redis-server 
            sleep 1s
            sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
            old_maxclients=$maxclients
            ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
            sleep 20s
            kill `cat /tmp/redis.pid`
            sleep 1s
        done
done


echo "2. Throughput-Latency 关系图" >> ./plot_data/memcached.dat
echo "2.1 maxclients" >> ./plot_data/memcached.dat
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo "maxclients: $i" >> ./plot_data/redis.dat

    for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
        do
            # echo $i
            # echo $j
            maxclients=$(($i*1000))
            ../tool/redis-5.0.5/redis-server 
            sleep 1s
            sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
            old_maxclients=$maxclients
            ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
            sleep 20s
            kill `cat /tmp/redis.pid`
            sleep 1s
        done
done


echo "2.2 maxclients+timeout+tcp-keepalive" >> ./plot_data/memcached.dat
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo "maxclients: $i" >> ./plot_data/redis.dat

    for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
        do
            # echo $i
            # echo $j
            maxclients=$(($i*1000))
            ../tool/redis-5.0.5/redis-server 
            sleep 1s
            sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
            old_maxclients=$maxclients
            ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
            sleep 20s
            kill `cat /tmp/redis.pid`
            sleep 1s
        done
done


echo "2.3 maxmemory-policy" >> ./plot_data/memcached.dat
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo "maxclients: $i" >> ./plot_data/redis.dat

    for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
        do
            # echo $i
            # echo $j
            maxclients=$(($i*1000))
            ../tool/redis-5.0.5/redis-server 
            sleep 1s
            sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
            old_maxclients=$maxclients
            ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
            sleep 20s
            kill `cat /tmp/redis.pid`
            sleep 1s
        done
done


echo "2.4 RDB AOF" >> ./plot_data/memcached.dat
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo "maxclients: $i" >> ./plot_data/redis.dat

    for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
        do
            # echo $i
            # echo $j
            maxclients=$(($i*1000))
            ../tool/redis-5.0.5/redis-server 
            sleep 1s
            sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
            old_maxclients=$maxclients
            ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
            sleep 20s
            kill `cat /tmp/redis.pid`
            sleep 1s
        done
done


echo "3. Memory utilization 柱状图" >> ./plot_data/memcached.dat
echo "3.1 maxmemory-policy" >> ./plot_data/memcached.dat
for i in 1 2 3 4 5 6 7 8 9 10;
do
    echo "maxclients: $i" >> ./plot_data/redis.dat

    for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
        do
            # echo $i
            # echo $j
            maxclients=$(($i*1000))
            ../tool/redis-5.0.5/redis-server 
            sleep 1s
            sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
            old_maxclients=$maxclients
            ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
            sleep 20s
            kill `cat /tmp/redis.pid`
            sleep 1s
        done
done


# echo "===================== Throughput-Latency关系图========================" >> ./plot_data/memcached.dat
# echo "maxclients" >> ./plot_data/redis.dat

# for i in 1 2 3 4 5 6 7 8 9 10;
# do
#     echo "maxclients: $i" >> ./plot_data/redis.dat

#     for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
#         do
#             # echo $i
#             # echo $j
#             maxclients=$(($i*1000))
#             ../tool/redis-5.0.5/redis-server 
#             sleep 1s
#             sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
#             old_maxclients=$maxclients
#             ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
#             sleep 20s
#             kill `cat /tmp/redis.pid`
#             sleep 1s
#         done
# done

# echo "===================== Throughput与单参数关系图========================" >> ./plot_data/redis.dat

# for i in 1 2 3 4 5 6 7 8 9 10;
# do
#     echo "maxclients: $i" >> ./plot_data/redis.dat
#     maxclients=$(($i*1000))
#     ../tool/redis-5.0.5/redis-server 
#     sleep 1s
#     sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
#     old_maxclients=$maxclients
#     ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
#     sleep 20s
#     kill `cat /tmp/redis.pid`
#     sleep 1s
# done
# echo "===================== Throughput与多参数关系图========================" >> ./plot_data/redis.dat
# echo "maxclients + maxmemory－policy" >> ./plot_data/redis.dat

# for i in 1 2 3 4 5 6 7 8 9 10;
# do
#     echo "maxclients: $i" >> ./plot_data/redis.dat

#     for policy in volatile-lru allkeys-lru volatile-random allkeys-random volatile-ttl noeviction;
#         do
#             # echo $i
#             # echo $j
#             maxclients=$(($i*1000))
#             ../tool/redis-5.0.5/redis-server 
#             sleep 1s
#             sed -i "s/maxclients $old_maxclients/maxclients $maxclients/g" ../tool/redis-5.0.5/redis.conf
#             sed -i "s/maxclients $old_policy/maxclients $policy/g" ../tool/redis-5.0.5/redis.conf
#             old_maxclients=$maxclients
#             old_policy=$policy
#             ../tool/redis-5.0.5/redis-benchmark -c 100 -n 100000
#             sleep 20s
#             kill `cat /tmp/redis.pid`
#             sleep 1s
#         done
# done