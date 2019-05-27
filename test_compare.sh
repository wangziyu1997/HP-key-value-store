cd ./plot_data
rm memcached.dat
touch memcached.dat
cd ..

echo "1. Concurrent Connections-Throughput 关系图" >> ./plot_data/memcached.dat
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

echo "3. Writes-Memory utilization 关系图" >> ./plot_data/memcached.dat
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

echo "4. Writes-Items 关系图" >> ./plot_data/memcached.dat
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

echo "5. Writes-Latency 关系图" >> ./plot_data/memcached.dat
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