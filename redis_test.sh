#!/bin/sh
#/usr/local/tool/redis-1.5.14/redis -d -l 127.0.0.1 -p 11211 -u root -m 64 -c 1024 -P /var/run/redis.pid
#1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63
#threads,maxconns,chunk_size,growth_factor,lru_maintatiner_thread,lru_segmented,tmp_lru,-C,-L
#maxmemory_policy,maxmemory,maxmemory-samples,RDB,AOF,maxclients

cd ./plot_data
rm redis.dat
touch redis.dat
cd ..

#对于不同线程数　response time 与　throughput的关系
# echo "threads" >> ./plot_data/redis.dat

# for i in 1 2 3 4 10 20 30 40;
# do
#     echo "Thread　number: $i" >> ./plot_data/redis.dat

#     for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
#         do
#             # echo $i
#             # echo $j
#             call_rate=$(($j*100))
#             ../tool/redis-1.5.14/redis -d -m 1024 -u root -p 11211 -P /tmp/redis.pid -t $i
#             sleep 1s
#             ../tool/twemperf/src/mcperf --linger=0 --timeout=5 --num-conns=100 --conn-rate=10000 --num-calls=1000 --call-rate=$call_rate --sizes=u10,1024 --method=get --port=11211 
#             sleep 20s
#             kill `cat /tmp/redis.pid`
#             sleep 1s
#         done
# done

# echo "-L" >> ./plot_data/redis.dat

# for i in 1 2 3 4 10 20 30 40;
# do
#     echo "Thread　number: $i" >> ./plot_data/redis.dat

#     for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
#         do
#             # echo $i
#             # echo $j
#             call_rate=$(($j*100))
#             ../tool/redis-1.5.14/redis -d -m 1024 -u root -p 11211 -P /tmp/redis.pid -t $i
#             sleep 1s
#             ../tool/twemperf/src/mcperf --linger=0 --timeout=5 --num-conns=100 --conn-rate=10000 --num-calls=1000 --call-rate=$call_rate --sizes=u10,1024 --method=get --port=11211 
#             sleep 20s
#             kill `cat /tmp/redis.pid`
#             sleep 1s
#         done
# done

# echo "-C" >> ./plot_data/redis.dat

# for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20;
# for i in 1 2 3 4 10 20 30 40;
# do
#     echo "Thread　number: $i" >> ./plot_data/redis.dat

#     for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25;
#         do
#             # echo $i
#             # echo $j
#             call_rate=$(($j*100))
#             ../tool/redis-1.5.14/redis -d -m 1024 -u root -p 11211 -P /tmp/redis.pid -t $i
#             sleep 1s
#             ../tool/twemperf/src/mcperf --linger=0 --timeout=5 --num-conns=100 --conn-rate=10000 --num-calls=1000 --call-rate=$call_rate --sizes=u10,1024 --method=get --port=11211 
#             sleep 20s
#             kill `cat /tmp/redis.pid`
#             sleep 1s
#         done
# done

echo "===================== Throughput与单参数关系图========================" >> ./plot_data/redis.dat
for i in 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63;
do
    /usr/local/tool/redis-1.5.14/redis -d -m 1024 -u root -p 11211 -P /tmp/redis.pid -t $i
    sleep 1s
    echo "[Thread $i]: redis started"
    
    echo -n $i >> ./plot_data/threads.dat
    
    /usr/local/tool/twemperf/src/mcperf --linger=0 --timeout=5 --num-conns=100 --conn-rate=1000 --num-calls=10000 --call-rate=1000 --sizes=u10,1024 --method=get --port=11211
    sleep 20s
    echo "[Thread $i]: mcperf executed"

    kill `cat /tmp/redis.pid`
    sleep 1s
    echo "[Thread $i]: redis killed"
done



echo "maxconns" >> ./plot_data/redis.dat

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20;
do
    
    factor=$(echo "1.0 $i"|awk '{print ($1+0.05*$2)}')
    echo $factor
    /usr/local/tool/redis-1.5.14/redis -d -m 1024 -u root -p 11211 -P /tmp/redis.pid -f $factor
    sleep 1s
    echo "[Growth factor $factor]: redis started"
    
    echo -n $factor >> ./plot_data/redis.dat
    
    /usr/local/tool/twemperf/src/mcperf --linger=0 --timeout=5 --num-conns=100 --conn-rate=1000 --num-calls=10000 --call-rate=1000 --sizes=u10,1024 --method=get --port=11211
    sleep 20s
    echo "[Growth factor $factor]: mcperf executed"

    kill `cat /tmp/redis.pid`
    sleep 1s
    echo "[Growth factor $factor]: redis killed"
done


echo "growth_factor" >> ./plot_data/redis.dat

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20;
do
    
    factor=$(echo "1.0 $i"|awk '{print ($1+0.05*$2)}')
    echo $factor
    ../tool/redis-1.5.14/redis -d -m 1024 -u root -p 11211 -P /tmp/redis.pid -f $factor
    sleep 1s
    echo "[Growth factor $factor]: redis started"
    
    echo -n $factor >> ./plot_data/redis.dat
    
    ../tool/twemperf/src/mcperf --linger=0 --timeout=5 --num-conns=100 --conn-rate=1000 --num-calls=10000 --call-rate=1000 --sizes=u10,1024 --method=get --port=11211
    sleep 20s
    echo "[Growth factor $factor]: mcperf executed"

    kill `cat /tmp/redis.pid`
    sleep 1s
    echo "[Growth factor $factor]: redis killed"
done

echo "chunk_size" >> ./plot_data/redis.dat

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20;
do
    
    factor=$(echo "1.0 $i"|awk '{print ($1+0.05*$2)}')
    echo $factor
    /usr/local/tool/redis-1.5.14/redis -d -m 1024 -u root -p 11211 -P /tmp/redis.pid -f $factor
    sleep 1s
    echo "[Growth factor $factor]: redis started"
    
    echo -n $factor >> ./plot_data/redis.dat
    
    /usr/local/tool/twemperf/src/mcperf --linger=0 --timeout=5 --num-conns=100 --conn-rate=1000 --num-calls=10000 --call-rate=1000 --sizes=u10,1024 --method=get --port=11211
    sleep 20s
    echo "[Growth factor $factor]: mcperf executed"

    kill `cat /tmp/redis.pid`
    sleep 1s
    echo "[Growth factor $factor]: redis killed"
done

# echo "===================== Throughput与多参数关系图========================" >> ./plot_data/redis.dat
# for i in 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63;
# do
#     /usr/local/tool/redis-1.5.14/redis -d -m 1024 -u root -p 11211 -P /tmp/redis.pid -t $i
#     sleep 1s
#     echo "[Thread $i]: redis started"
    
#     echo -n $i >> ./plot_data/threads.dat
    
#     /usr/local/tool/twemperf/src/mcperf --linger=0 --timeout=5 --num-conns=100 --conn-rate=1000 --num-calls=10000 --call-rate=1000 --sizes=u10,1024 --method=get --port=11211
#     sleep 20s
#     echo "[Thread $i]: mcperf executed"

#     kill `cat /tmp/redis.pid`
#     sleep 1s
#     echo "[Thread $i]: redis killed"
# done



# echo "maxconns" >> ./plot_data/redis.dat

# for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20;
# do
    
#     factor=$(echo "1.0 $i"|awk '{print ($1+0.05*$2)}')
#     echo $factor
#     /usr/local/tool/redis-1.5.14/redis -d -m 1024 -u root -p 11211 -P /tmp/redis.pid -f $factor
#     sleep 1s
#     echo "[Growth factor $factor]: redis started"
    
#     echo -n $factor >> ./plot_data/redis.dat
    
#     /usr/local/tool/twemperf/src/mcperf --linger=0 --timeout=5 --num-conns=100 --conn-rate=1000 --num-calls=10000 --call-rate=1000 --sizes=u10,1024 --method=get --port=11211
#     sleep 20s
#     echo "[Growth factor $factor]: mcperf executed"

#     kill `cat /tmp/redis.pid`
#     sleep 1s
#     echo "[Growth factor $factor]: redis killed"
# done
