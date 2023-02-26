ini_open("Color")
for (i=0; i<21; i+=1)
{
    n = ini_read_real("color",string(i),0)
    
    if n = 0
        ini_write_real("trade",string(i),2)
    if n = 1
        ini_write_real("trade",string(i),0)
    if n > 1
        ini_write_real("trade",string(i),1)     
}
ini_close()

room_restart()
