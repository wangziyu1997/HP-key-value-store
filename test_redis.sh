#!/bin/sh
#../tool/redis-5.0.5/redis-server -d -l 127.0.0.1 -p 11211 -u root -m 64 -c 1024 -P /var/run/redis.pid
#1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63
#threads,maxconns,chunk_size,growth_factor,lru_maintatiner_thread,lru_segmented,tmp_lru,-C,-L
#maxmemory－policy,maxmemory,maxclients, timeout, tcp-keepalive, save(注释掉), appendfsync(11 10 01 00)
# cd ./plot_data
# rm redis.dat
# touch redis.dat
# rm redis_memomory.dat
# touch redis_memomory.dat
# cd ..
# sed -i "s/# maxmemory <bytes>/maxmemory 64mb/g" ../tool/redis-5.0.5/redis.conf
# sed -i "s/# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/g" ../tool/redis-5.0.5/redis.conf
# old_policy="allkeys-lru"
# echo "CC-Throughput_Latency_set_nopipe" >> ./plot_data/redis.dat
# for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
# do
#     # echo $i
#     # echo $j
#     # maxclients=$(($i*1000))
#     ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
#     sleep 1s
#     echo -n $i >> ./plot_data/redis.dat
#     ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t set
#     sleep 20s
#     ../tool/redis-5.0.5/src/redis-cli shutdown
#     sleep 1s
# done

# echo "CC-Throughput_Latency_set_pipe" >> ./plot_data/redis.dat
# for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
# do
#     # echo $i
#     # echo $j
#     # maxclients=$(($i*1000))
#     ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
#     sleep 1s
#     echo -n $i >> ./plot_data/redis.dat
#     ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t set -P 16
#     sleep 20s
#     ../tool/redis-5.0.5/src/redis-cli shutdown
#     sleep 1s
# done

# echo "CC-Throughput_Latency_get_nopipe" >> ./plot_data/redis.dat
# for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
# do
#     # echo $i
#     # echo $j
#     # maxclients=$(($i*1000))
#     ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
#     sleep 1s
#     echo -n $i >> ./plot_data/redis.dat
#     ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t get
#     sleep 20s
#     ../tool/redis-5.0.5/src/redis-cli shutdown
#     sleep 1s
# done

# echo "CC-Throughput_Latency_get_pipe" >> ./plot_data/redis.dat
# for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
# do
#     # echo $i
#     # echo $j
#     # maxclients=$(($i*1000))
#     ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
#     sleep 1s
#     echo -n $i >> ./plot_data/redis.dat
#     ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t get -P 16
#     sleep 20s
#     ../tool/redis-5.0.5/src/redis-cli shutdown
#     sleep 1s
# done

# for j in 10 100 1000 10000 100000 
# do
#     echo "Throughput_set_persist$j" >> ./plot_data/redis.dat
#     for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
#     do
        
#         ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
#         sleep 1s
#         echo -n $i >> ./plot_data/redis.dat
#         ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t set -d $j
#         sleep 20s
#         ../tool/redis-5.0.5/src/redis-cli shutdown
#         sleep 1s
#     done
# done

# sed -i "s/appendfsync everysec/appendfsync no/g" ../tool/redis-5.0.5/redis.conf
# sed -i "s/save 900 1/# save 900 1/g" ../tool/redis-5.0.5/redis.conf
# sed -i "s/save 300 10/# save 300 10/g" ../tool/redis-5.0.5/redis.conf
# sed -i "s/save 60 10000/# save 60 10000/g" ../tool/redis-5.0.5/redis.conf


# for j in 10 100 1000 10000 100000 
# do
#     echo "Throughput_set_nopersist$j" >> ./plot_data/redis.dat
#     for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
#     do
        
#         ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
#         sleep 1s
#         echo -n $i >> ./plot_data/redis.dat
#         ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t set -d $j
#         sleep 20s
#         ../tool/redis-5.0.5/src/redis-cli shutdown
#         sleep 1s
#     done
# done

# sed -i "s/appendfsync no/appendfsync everysec/g" ../tool/redis-5.0.5/redis.conf
# sed -i "s/# save 900 1/save 900 1/g" ../tool/redis-5.0.5/redis.conf
# sed -i "s/# save 300 10/save 300 10/g" ../tool/redis-5.0.5/redis.conf
# sed -i "s/# save 60 10000/save 60 10000/g" ../tool/redis-5.0.5/redis.conf

for k in volatile-lru allkeys-lru volatile-lfu allkeys-lfu volatile-random allkeys-random volatile-ttl
do
    for j in 10 100 1000 10000 100000 
    do
        echo "$k $j bytes" >> ./plot_data/redis_memomory.dat
        for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
        do
            sed -i "s/maxmemory-policy $old_policy/maxmemory-policy $k/g" ../tool/redis-5.0.5/redis.conf
            # echo $k $old_policy
            old_policy=$k
            # echo "Throughput_set_$k$j" >> ./plot_data/redis.dat
            ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
            sleep 1s
            echo -n $i >> ./plot_data/redis.dat
            ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t set -d $j
            sleep 20s
            echo "$k $j bytes$i" >> ./plot_data/redis_memomory.dat
            printf "info memory\r\n" | ../tool/redis-5.0.5/src/redis-cli >> ./plot_data/redis_memomory.dat
            printf "quit\r\n" | ../tool/redis-5.0.5/src/redis-cli
            ../tool/redis-5.0.5/src/redis-cli shutdown
            sleep 1s
        done
    done
done