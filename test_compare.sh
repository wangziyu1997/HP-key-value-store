cd ./plot_data
rm compare.dat
rm top.dat
touch compare.dat
touch top.dat
cd ..
# ../tool/memtier_benchmark/memtier_benchmark -p 11211 -P memcache_binary -t $i -n $numbers
# ../tool/memtier_benchmark/memtier_benchmark -t $i -n $numbers

# top -b -n 1 | grep 'PID' -A 5 > ./plot_data/top.dat
sed -i "s/# maxmemory <bytes>/maxmemory 64mb/g" ../tool/redis-5.0.5/redis_original.conf
sed -i "s/# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/g" ../tool/redis-5.0.5/redis.conf

echo "1. Concurrent Connections-Throughput,Latency" >> ./plot_data/compare.dat
echo "memcached"　>> ./plot_data/compare.dat
echo "memcached"　>> ./plot_data/top.dat
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64;
do
    echo -n "memtier_threads: $i " >> ./plot_data/compare.dat
    echo -n "memtier_threads: $i " >> ./plot_data/top.dat
    numbers=$((20000/$i))
    ../tool/memcached-1.5.14/memcached -d -m 64 -u root -p 11211 -P /tmp/memcached.pid -t 20 
    sleep 1s
    nohup ../tool/memtier_benchmark/memtier_benchmark -p 11211 -P memcache_binary -t $i -n $numbers --ratio=1:1 &
    sleep 3s
    top -b -n 1 | grep 'memcached'>> ./plot_data/top.dat
    sleep 30s
    kill `cat /tmp/memcached.pid`
    sleep 1s

done
echo "redis"　>> ./plot_data/compare.dat
echo "redis"　>> ./plot_data/top.dat
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64;
do
    echo -n "memtier_threads: $i " >> ./plot_data/compare.dat
    echo -n "memtier_threads: $i " >> ./plot_data/top.dat
    numbers=$((20000/$i))
    ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis_original.conf &
    sleep 1s
    nohup ../tool/memtier_benchmark/memtier_benchmark -t $i -n $numbers --ratio=1:1 &
    sleep 3s
    top -b -n 1 | grep 'redis' >> ./plot_data/top.dat
    sleep 30s
    ../tool/redis-5.0.5/src/redis-cli shutdown
    sleep 1s
done