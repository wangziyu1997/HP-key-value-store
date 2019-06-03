import os
import re

thread_name = "CC_Throughput_set_threads_number1"+".dat"
evictions_name = "evictions100"+".dat"
bytes_name = "bytes100"+".dat"

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

# with open('./data/memcached_growth_factor.dat','r') as fr0:
#     for line in fr0:
#         stre(line)

# with open('./data/bytes_output.dat','r') as fr1:
#     for line in fr1:
#         cut1(line)

# with open('./data/evictions_output.dat','r') as fr2:
#     for line in fr2:
#         cut2(line)

with open('./data/memcached/original/memcached_threads.dat','r') as fr3:
    for line in fr3:
        cut3(line)