ini_open("wrs.ini")
for (i=0; i<global.tracks+1; i+=1)
    global.tracktimes[i,1] = ini_read_string("wrs",string(i),"1")
ini_close()
 
