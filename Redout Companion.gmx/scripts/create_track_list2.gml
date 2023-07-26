///Create Tracklist
if global.above_target = 1
{
    ini_open(global.mode)
    for (i=0; i<global.tracks+(global.tracks/5); i+=1)
        { 
        if ini_read_real(global.class,string(i),0) != 0
            ds_list_add(global.trackList,i)
        }
    ds_list_shuffle(global.trackList)   
    global.trackListI = 0
    ini_close()
    
    if ds_list_size(global.trackList) = 0
    {
        show_message("No track data disabling above target times")
        global.above_target = 0
        ini_open("options")
        ini_write_real("above","above",global.above_target)
        ini_close()
        room_restart()
        exit
    }
}
else
{
    global.trackListI = 0
    global.trackList = ds_list_create()
    if global.mode != "boss"
    {
        for (i=0; i<global.tracks; i+=1)
                ds_list_add(global.trackList,i)
    }
    else
    {
        for (i=60; i<global.tracks+(global.tracks/5); i+=1)
                ds_list_add(global.trackList,i)
    }
    ds_list_shuffle(global.trackList)  
}
