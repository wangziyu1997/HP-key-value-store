import os
import re

thread_name = "CC_Throughput_set_threads_number1"
evictions_name = "evictions100"
bytes_name = "bytes100"

pipe_name="CC-Throughput_Latency_set_nopipe"
persist_name="Throughput_set_persist10"
flag=1

def stre(s):
    # print(s)
    pattern = "growth_factor \d*\.\d*|STAT bytes \d*|evictions \d*"
    s = re.findall(pattern, s)
    
    if len(s)>0:
        data=s[0]
        if data[0]=='g':
            data=data+" "
            with open('bytes_output.dat','a+') as fw:
                fw.write(data)
            with open('evictions_output.dat','a+') as fw:
                fw.write(data)
        elif data[0]=='S':
            data=data+"\n"
            with open('bytes_output.dat','a+') as fw:
                fw.write(data)
        else:
            data=data+"\n"
            with open('evictions_output.dat','a+') as fw:
                fw.write(data)

def cut1(s):
    global bytes_name
    strs = s.split()
    print(strs)
    if len(strs)==1:
        bytes_name = "./data/"+strs[0]+".dat"
        print(bytes_name)
    else:
        data1=strs[1]+" "+strs[4]+"\n"
        print(bytes_name)
        print(data1)
        with open(bytes_name,'a+') as fw1:
                fw1.write(data1)

def cut2(s):
    global evictions_name
    strs = s.split()
    print(strs)
    if len(strs)==1:
        evictions_name = "./data/"+strs[0]+".dat"
        print(evictions_name)
    else:
        data2=strs[1]+" "+strs[3]+"\n"
        print(evictions_name)
        print(data2)
        with open(evictions_name,'a+') as fw2:
                fw2.write(data2)

def cut3(s):
    global thread_name
    strs = s.split()
    print(strs)
    if len(strs)==1:
        thread_name = strs[0]
        print(thread_name)
    elif len(strs)==3:
        data3=strs[0]+" "+strs[1]+"\n"
        data4=strs[0]+" "+strs[2]+"\n"

        thread_name_t="./data//memcached/concurrent_connections/"+thread_name+"_throughput.dat"
        thread_name_l="./data//memcached/concurrent_connections/"+thread_name+"_latency.dat"
        print(thread_name_t)
        print(thread_name_l)

        with open(thread_name_t,'a+') as fw3:
                fw3.write(data3)
        with open(thread_name_l,'a+') as fw4:
                fw4.write(data4)
    # elif len(strs)==2:
    #     data5=strs[0]+" "+strs[1]+"\n"
    #     thread_name_tl="./data//memcached/concurrent_connections"+thread_name+".dat"
    #     with open(thread_name_tl,'a+') as fw5:
    #             fw5.write(data5)

def redis_pipe(s):
    print(s)
    global pipe_name
    strs = s.split()
    print(strs)
    if len(strs)==1:
        pipe_name = strs[0]
    else:
        pipe_name_t = "./data/redis/pipe/"+pipe_name+"_throughput.dat"
        pipe_name_l = "./data/redis/pipe/"+pipe_name+"_latency.dat"
        data_t=strs[0]+" "+strs[1]+"\n"
        data_l=strs[0]+" "+strs[2]+"\n"
        with open(pipe_name_t,'a+') as pipe_t:
                pipe_t.write(data_t)
        with open(pipe_name_l,'a+') as pipe_l:
                pipe_l.write(data_l)
        
def redis_persist(s):
    print(s)
    global persist_name
    strs = s.split()
    print(strs)
    if len(strs)==1:
        persist_name=strs[0]
    else:
        persist_name_t = "./data/redis/persist/"+persist_name+"_throughput.dat"
        persist_name_l = "./data/redis/persist/"+persist_name+"_latency.dat"
        pdata_t=strs[0]+" "+strs[1]+"\n"
        pdata_l=strs[0]+" "+strs[2]+"\n"
        with open(persist_name_t,'a+') as per_t:
                per_t.write(pdata_t)
        with open(persist_name_l,'a+') as per_l:
                per_l.write(pdata_l)

def streRedis(s):
    global flag
    # print(s)
    pattern = "volatile-lru|allkeys-lru|volatile-lfu|allkeys-lfu|volatile-random|allkeys-random|volatile-ttl|used_memory:\d*|evicted_keys:\d*"
    s = re.findall(pattern, s)
    if len(s)>0:
        data=s[0].split(':')
        if len(data) == 1:
            name=data[0]+" "
            print(name)
            if flag:
                with open('./data/redis/maxmemory/maxmemory-policy_used_memory.dat','a+') as fw1:
                    fw1.write(name)
                flag=1-flag
            
            else:
                with open('./data/redis/maxmemory/maxmemory-policy_evicted_keys.dat','a+') as fw2:
                    fw2.write(name)
                flag=1-flag
        elif data[0][0]=='u':
            with open('./data/redis/maxmemory/maxmemory-policy_used_memory.dat','a+') as fw1:
                fw1.write(data[1]+'\n')
        else:
            with open('./data/redis/maxmemory/maxmemory-policy_evicted_keys.dat','a+') as fw2:
                fw2.write(data[1]+'\n')
                
        # elif data[0]=='S':
        #     data=data+"\n"
        #     with open('bytes_output.dat','a+') as fw:
        #         fw.write(data)
        # else:
        #     data=data+"\n"
        #     with open('evictions_output.dat','a+') as fw:
        #         fw.write(data)
# with open('./data/memcached_growth_factor.dat','r') as fr0:
#     for line in fr0:
#         stre(line)

# with open('./data/bytes_output.dat','r') as fr1:
#     for line in fr1:
#         cut1(line)

# with open('./data/evictions_output.dat','r') as fr2:
#     for line in fr2:
#         cut2(line)

# with open('./data/memcached/original/memcached_threads.dat','r') as fr3:
#     for line in fr3:
#         cut3(line)

# with open('./data/redis/redis1.dat','r') as redis1:
#     for line in redis1:
#         redis_pipe(line)

# with open('./data/redis/redis3.dat','r') as redis3:
#     for line in redis3:
#         redis_persist(line)


with open('./data/redis/original/redis_memory.dat','r') as redism:
    for line in redism:
        streRedis(line)

