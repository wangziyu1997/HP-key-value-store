cd ./plot_data
rm compare.dat
rm top.dat
touch compare.dat
touch top.dat
cd ..
#高并发场景
sed -i "s/# maxmemory <bytes>/maxmemory 64mb/g" ../tool/redis-5.0.5/redis_original.conf

echo "1. Concurrent Connections-Throughput,Latency" >> ./plot_data/compare.dat
echo "memcached"?>> ./plot_data/compare.dat
echo "memcached"?>> ./plot_data/top.dat
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15;
do
    echo -n "memtier_threads: $i " >> ./plot_data/compare.dat
    echo "memtier_threads: $i " >> ./plot_data/top.dat
    
    ../tool/memcached-1.5.14/memcached -d -m 64 -u root -p 11211 -P /tmp/memcached.pid -t 20 
    sleep 1s
    nohup ../tool/memtier_benchmark/memtier_benchmark -p 11211 -P memcache_binary -t $i -n 20000 --ratio=1:1 &
    top -b -n 30 | grep 'memcached'>> ./plot_data/top.dat
    # sleep 30s
    kill `cat /tmp/memcached.pid`
    sleep 1s

done
echo "redis"?>> ./plot_data/compare.dat
echo "redis"?>> ./plot_data/top.dat
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15;
do
    echo -n "memtier_threads: $i " >> ./plot_data/compare.dat
    echo "memtier_threads: $i " >> ./plot_data/top.dat
    
    ../tool/redis-5.0.5/src/redis-server ../tool/redis-5.0.5/redis_original.conf &
    sleep 1s
    nohup ../tool/memtier_benchmark/memtier_benchmark -t $i -n 20000 --ratio=1:1 &
    top -b -n 30 | grep 'redis' >> ./plot_data/top.dat
    # sleep 30s
    ../tool/redis-5.0.5/src/redis-cli shutdown
    sleep 1s
done


#数据多样化场景
./bin/ycsb load memcached -s -P workloads/workloada -P ./memcached/conf/memcached.properties > MA_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloada -P ./memcached/conf/memcached.properties > MA_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloada -p "redis.host=127.0.0.1" -p "redis.port=6379" > RA_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloada -p "redis.host=127.0.0.1" -p "redis.port=6379" > RA_outputRun.txt





./bin/ycsb load memcached -s -P workloads/workloadb -P ./memcached/conf/memcached.properties > MB_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloadb -P ./memcached/conf/memcached.properties > MB_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloadb -p "redis.host=127.0.0.1" -p "redis.port=6379" > RB_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloadb -p "redis.host=127.0.0.1" -p "redis.port=6379" > RB_outputRun.txt




./bin/ycsb load memcached -s -P workloads/workloadc -P ./memcached/conf/memcached.properties > MC_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloadc -P ./memcached/conf/memcached.properties > MC_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloadc -p "redis.host=127.0.0.1" -p "redis.port=6379" > RC_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloadc -p "redis.host=127.0.0.1" -p "redis.port=6379" > RC_outputRun.txt




./bin/ycsb load memcached -s -P workloads/workloadd -P ./memcached/conf/memcached.properties > MD_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloadd -P ./memcached/conf/memcached.properties > MD_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloadd -p "redis.host=127.0.0.1" -p "redis.port=6379" > RD_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloadd -p "redis.host=127.0.0.1" -p "redis.port=6379" > RD_outputRun.txt




./bin/ycsb load memcached -s -P workloads/workloade -P ./memcached/conf/memcached.properties > ME_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloade -P ./memcached/conf/memcached.properties > ME_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloade -p "redis.host=127.0.0.1" -p "redis.port=6379" > RE_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloade -p "redis.host=127.0.0.1" -p "redis.port=6379" > RE_outputRun.txt



./bin/ycsb load memcached -s -P workloads/workloadf -P ./memcached/conf/memcached.properties > MF_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloadf -P ./memcached/conf/memcached.properties > MF_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloadf -p "redis.host=127.0.0.1" -p "redis.port=6379" > RF_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloadf -p "redis.host=127.0.0.1" -p "redis.port=6379" > RF_outputRun.txt

