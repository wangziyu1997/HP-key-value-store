import os
import re
import xlwt 

thread_name = "CC_Throughput_set_threads_number1"
evictions_name = "evictions100"
bytes_name = "bytes100"

pipe_name="CC-Throughput_Latency_set_nopipe"
persist_name="Throughput_set_persist10"
aof_name='Throughput_set_no10'
flag=1

 
def txt_xls(filename,xlsname):

    try:
        f = open(filename) 
        xls=xlwt.Workbook()
        
        sheet = xls.add_sheet('sheet1',cell_overwrite_ok=True) 
        x = 0 
        while True:
          
            line = f.readline() 
            if not line: 
                break  
            for i in range(len(line.split(','))):
                item=line.split(',')[i]
                sheet.write(x,i,item) 
            x += 1
        f.close()
        xls.save(xlsname) 
    except:
        raise


def stre(s):
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
                
def compare_cpu_r(num,s):
    strs=s.split()
    if len(strs)==12:
        with open('./data/compare/redistop.dat','a+') as fw1:
            fw1.write(str(num)+' '+strs[8]+'\n')

def hit_r(num,s,new_file):
    with open(new_file,'a+') as fw1:
        fw1.write(str(num)+' '+s)

def compare_cpu_m(num,s):
    strs=s.split()
    if len(strs)==12:
        with open('./data/memcached/network_model_memtier/memtop.dat','a+') as fw1:
            fw1.write(str(num)+' '+strs[8]+'\n')     

def hitrateRedis(s,filename):
    global flag
    # print(s)
    pattern = "evicted_keys:\d*|keyspace_hits:\d*|keyspace_misses:\d*|used_memory:\d*|maxmemory:\d*"
    s = re.findall(pattern, s)
    if len(s)>0:
        data=s[0].split(':')
        pdata=data[0]+' '+data[1]+' '
        if(data[0][0]=='m'):
            pdata=pdata+'\n'
        print(pdata)
        with open(filename,'a+') as fw1:
                    fw1.write(pdata)

def redis_aof(s):
    print(s)
    global aof_name
    strs = s.split()
    print(strs)
    if len(strs)==1:
        aof_name=strs[0]
    else:
        p_name = "./data/redis/AOF/"+aof_name+".dat"
        pdata=strs[0]+" "+strs[1]+" "+strs[2]+"\n"
        with open(p_name,'a+') as per:
                per.write(pdata)

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


# with open('./data/redis/original/redis_memory.dat','r') as redism:
#     for line in redism:
#         streRedis(line)

# topnum = 0
# with open('./plot_data/top_redis.dat','r') as redistop:
#     for line in redistop:
#         topnum+=1
#         compare_cpu_r(topnum,line) 
    
# topnum = 0
# with open('./plot_data/top_memcached.dat','r') as memtop:
#     for line in memtop:
#         topnum+=1
#         compare_cpu_m(topnum,line) 

# with open('./data/redis/redis_hitrate/allkeys-lru.dat','r') as redish:
#     for line in redish:
#         hitrateRedis(line,'./data/redis/redis_hitrate/allkeys-lru-p.dat')

# with open('./data/redis/redis_hitrate/allkeys-lfu.dat','r') as redish:
#     for line in redish:
#         hitrateRedis(line,'./data/redis/redis_hitrate/allkeys-lfu-p.dat')
# with open('./data/redis/redis_hitrate/allkeys-random.dat','r') as redish:
#     for line in redish:
#         hitrateRedis(line,'./data/redis/redis_hitrate/allkeys-random-p.dat')

# with open('./data/redis/redis_hitrate/volatile-lfu.dat','r') as redish:
#     for line in redish:
#         hitrateRedis(line,'./data/redis/redis_hitrate/volatile-lfu-p.dat')
  
# with open('./data/redis/redis_hitrate/volatile-lru.dat','r') as redish:
#     for line in redish:
#         hitrateRedis(line,'./data/redis/redis_hitrate/volatile-lru-p.dat')

# with open('./data/redis/redis_hitrate/volatile-ttl.dat','r') as redish:
#     for line in redish:
#         hitrateRedis(line,'./data/redis/redis_hitrate/volatile-ttl-p.dat')
# with open('./data/redis/redis_hitrate/volatile-random.dat','r') as redish:
#     for line in redish:
#         hitrateRedis(line,'./data/redis/redis_hitrate/volatile-random-p.dat')

# with open('./data/redis/redis_aof.dat','r') as redisa:
#     for line in redisa:
#         redis_aof(line) 

# path1 = r'./data/compare/1threadsYCSB'
# filenames1 = os.listdir(path1)
# for filename1 in filenames1:
#     xlsname1=filename1.replace('txt','xls')
#     txt_xls(path1+'/'+filename1,path1+'/'+xlsname1)

# path10 = r'./data/compare/10threadsYCSB'
# filenames10 = os.listdir(path10)
# for filename10 in filenames10:
#     xlsname10=filename10.replace('txt','xls')
#     txt_xls(path10+'/'+filename10,path10+'/'+xlsname10)

# path20 = r'./data/compare/20threadsYCSB'
# filenames20 = os.listdir(path20)
# for filename20 in filenames20:
#     xlsname20=filename20.replace('txt','xls')
#     txt_xls(path20+'/'+filename20,path20+'/'+xlsname20)

# topnum = 0
# with open('./data/memcached/memtop.dat','r') as memtop:
#     for line in memtop:
#         topnum+=1
#         topnum=topnum%450
#         if topnum==0:
#             topnum=450
#         compare_cpu_m(topnum,line) 

# path = r'./data/redis/redis_hitrate/'
# filenames = os.listdir(path)
# for filename in filenames:
#     print(filename)
#     topnum = 0
#     with open(path+filename,'r') as redish:
#         for line in redish:
#             topnum+=1
#             newfile=filename.replace('-p','')
#             hit_r(topnum,line,path+newfile) 

path = r'./data/memcached/network_model_memtier/tl/'
filenames = os.listdir(path)
for filename in filenames:
    print(filename)
    topnum = 0
    with open(path+filename,'r') as mtl:
        for line in mtl:
            topnum+=1
            newfile=filename.replace('_tl','')
            hit_r(topnum,line,path+newfile) 