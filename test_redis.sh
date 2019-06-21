#!/bin/sh
# Redis命中率=keyspace_hits/（keyspace_hits+keyspace_misses）

cd ./plot_data
rm redis.dat
touch redis.dat
rm redis_memory.dat
touch redis_memory.dat
cd ..
sed -i "s/# maxmemory <bytes>/maxmemory 64mb/g" ../tool/redis-5.0.5/redis.conf
sed -i "s/# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/g" ../tool/redis-5.0.5/redis.conf
old_policy="allkeys-lru"
echo "CC-Throughput_Latency_set_nopipe" >> ./plot_data/redis.dat
for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
do
    # echo $i
    # echo $j
    # maxclients=$(($i*1000))
    ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
    sleep 1s
    echo -n $i >> ./plot_data/redis.dat
    sleep 5s
    ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t set
    sleep 20s
    ../tool/redis-5.0.5/src/redis-cli shutdown
    sleep 1s
done

echo "CC-Throughput_Latency_set_pipe" >> ./plot_data/redis.dat
for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
do
    # echo $i
    # echo $j
    # maxclients=$(($i*1000))
    ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
    sleep 1s
    echo -n $i >> ./plot_data/redis.dat
    ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t set -P 16
    sleep 20s
    ../tool/redis-5.0.5/src/redis-cli shutdown
    sleep 1s
done

echo "CC-Throughput_Latency_get_nopipe" >> ./plot_data/redis.dat
for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
do
    # echo $i
    # echo $j
    # maxclients=$(($i*1000))
    ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
    sleep 1s
    echo -n $i >> ./plot_data/redis.dat
    ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t get
    sleep 20s
    ../tool/redis-5.0.5/src/redis-cli shutdown
    sleep 1s
done

echo "CC-Throughput_Latency_get_pipe" >> ./plot_data/redis.dat
for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
do
    # echo $i
    # echo $j
    # maxclients=$(($i*1000))
    ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
    sleep 1s
    echo -n $i >> ./plot_data/redis.dat
    ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t get -P 16
    sleep 20s
    ../tool/redis-5.0.5/src/redis-cli shutdown
    sleep 1s
done

for j in 10 100 1000 10000 100000 
do
    echo "Throughput_set_persist$j" >> ./plot_data/redis.dat
    for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
    do
        
        ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
        sleep 1s
        echo -n $i >> ./plot_data/redis.dat
        ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t set -d $j
        sleep 20s
        ../tool/redis-5.0.5/src/redis-cli shutdown
        sleep 1s
    done
done

sed -i "s/appendonly no/appendonly yes/g" ../tool/redis-5.0.5/redis.conf

for j in 10 100 1000 10000 100000 
do
    echo "Throughput_set_nopersist$j" >> ./plot_data/redis.dat
    for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
    do
        
        ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
        sleep 1s
        echo -n $i >> ./plot_data/redis.dat
        ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t set -d $j
        sleep 20s
        ../tool/redis-5.0.5/src/redis-cli shutdown
        sleep 1s
    done
done

sed -i "s/# appendfsync always/appendfsync always/g" ../tool/redis-5.0.5/redis.conf
sed -i "s/appendfsync everysec/# appendfsync everysec/g" ../tool/redis-5.0.5/redis.conf

for j in 10 100 1000 10000 100000 
do
    echo "Throughput_set_nopersist$j" >> ./plot_data/redis.dat
    for i in 1 10 50 100 200 300 400 500 600 700 800 900 1000;
    do
        
        ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
        sleep 1s
        echo -n $i >> ./plot_data/redis.dat
        ../tool/redis-5.0.5/src/redis-benchmark -c $i -n 500000 -t set -d $j
        sleep 20s
        ../tool/redis-5.0.5/src/redis-cli shutdown
        sleep 1s
    done
done
sed -i "s/appendonly yes/appendonly no/g" ../tool/redis-5.0.5/redis.conf
sed -i "s/appendfsync always/# appendfsync always/g" ../tool/redis-5.0.5/redis.conf
sed -i "s/# appendfsync everysec/appendfsync everysec/g" ../tool/redis-5.0.5/redis.conf

for k in volatile-lru allkeys-lru volatile-lfu allkeys-lfu volatile-random allkeys-random volatile-ttl
do
    sed -i "s/maxmemory-policy $old_policy/maxmemory-policy $k/g" ../tool/redis-5.0.5/redis.conf
    # echo $k $old_policy
    old_policy=$k
    # echo "Throughput_set_$k$j" >> ./plot_data/redis.dat
    ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis.conf &
    sleep 1s
    ../tool/redis-5.0.5/src/redis-benchmark -c 100 -n 1000000 -t set -r 100000000
    sleep 30s
    echo "$k" >> ./plot_data/redis_memory.dat
    printf "info memory\r\n" | ../tool/redis-5.0.5/src/redis-cli >> ./plot_data/redis_memory.dat
    printf "info stats\r\n" | ../tool/redis-5.0.5/src/redis-cli >> ./plot_data/redis_memory.dat
    printf "quit\r\n" | ../tool/redis-5.0.5/src/redis-cli
    ../tool/redis-5.0.5/src/redis-cli shutdown
    sleep 1s
done

#命中率测试
old_policy="allkeys-lru"
for k in volatile-lru volatile-lfu allkeys-lfu volatile-random allkeys-random volatile-ttl allkeys-lru
do
    sed -i "s/maxmemory-policy $old_policy/maxmemory-policy $k/g" ../tool/redis-5.0.5/redis_maxpolicy.conf
    # echo $k $old_policy
    old_policy=$k
    # echo "Throughput_set_$k$j" >> ./plot_data/redis.dat
    ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis_maxpolicy.conf &
    sleep 1s
    nohup ../tool/memtier_benchmark/memtier_benchmark --random-data --data-size-range=100000-200000 --data-size-pattern=S --key-minimum=20000 --key-maximum=40000 --key-pattern=G:G --key-stddev=10 --key-median=30000 &
    t=0
    echo "$k" >> ./plot_data/$k.dat
    while [ $t -le 240 ]
    do
        printf "info stats\r\n" | ../tool/redis-5.0.5/src/redis-cli >> ./plot_data/$k.dat
        t=$(($t+1))
        sleep 1s
    done

    printf "quit\r\n" | ../tool/redis-5.0.5/src/redis-cli
    ../tool/redis-5.0.5/src/redis-cli shutdown
    sleep 1s
done