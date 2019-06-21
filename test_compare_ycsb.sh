../../tool/memcached-1.5.14/memcached -d -m 64 -u root -p 11211 -P /tmp/memcached.pid -t 20
../../tool/redis-5.0.5/src/redis-server ../../tool/redis-5.0.5/redis_original.conf &

./bin/ycsb load memcached -s -P workloads/workloada -P ./memcached/conf/memcached.properties -threads 20 > ./compare_data/MA_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloada -P ./memcached/conf/memcached.properties -threads 20 > ./compare_data/MA_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloada -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 20 > ./compare_data/RA_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloada -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 20 > ./compare_data/RA_outputRun.txt





./bin/ycsb load memcached -s -P workloads/workloadb -P ./memcached/conf/memcached.properties -threads 20 > ./compare_data/MB_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloadb -P ./memcached/conf/memcached.properties -threads 20 > ./compare_data/MB_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloadb -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 20 > ./compare_data/RB_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloadb -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 20 > ./compare_data/RB_outputRun.txt




./bin/ycsb load memcached -s -P workloads/workloadc -P ./memcached/conf/memcached.properties -threads 20 > ./compare_data/MC_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloadc -P ./memcached/conf/memcached.properties -threads 20 > ./compare_data/MC_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloadc -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 20 > ./compare_data/RC_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloadc -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 20 > ./compare_data/RC_outputRun.txt




./bin/ycsb load memcached -s -P workloads/workloadd -P ./memcached/conf/memcached.properties -threads 20 > ./compare_data/MD_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloadd -P ./memcached/conf/memcached.properties -threads 20 > ./compare_data/MD_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloadd -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 20 > ./compare_data/RD_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloadd -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 20 > ./compare_data/RD_outputRun.txt



./bin/ycsb load memcached -s -P workloads/workloadf -P ./memcached/conf/memcached.properties -threads 20 > ./compare_data/MF_outputLoad.txt

./bin/ycsb run memcached -s -P workloads/workloadf -P ./memcached/conf/memcached.properties -threads 20 > ./compare_data/MF_outputRun.txt

./bin/ycsb load redis -s -P workloads/workloadf -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 20 > ./compare_data/RF_outputLoad.txt

./bin/ycsb run redis -s -P workloads/workloadf -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 20 > ./compare_data/RF_outputRun.txt

cd ./compare_data
cp *outputLoad.txt ../../../HP-key-value-store/plot_data/
cp *outputRun.txt ../../../HP-key-value-store/plot_data/
cd ..
