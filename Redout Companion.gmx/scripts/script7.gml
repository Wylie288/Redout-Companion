///Create Tracklist
if room = rm_random
{
    ds_list_empty(global.trackList)
    ini_open(global.mode)
    global.trackList = ds_list_create()
    for (i=0; i<global.tracks+(global.tracks/8); i+=1)
        {
        if ini_read_real(global.class,string(i),0) != 0
            ds_list_add(global.trackList,i)
        }
    ds_list_shuffle(global.trackList)   
    global.trackListI = 0
    ini_close()
    
    if global.above_target = 1
    {
        found = 1
        while(found != 0)
        {
            if global.allowRepeat = 1
                ds_list_shuffle(global.trackList)    
            else
            {
                if global.trackListI < ds_list_size(global.trackList) - 1
                    global.trackListI += 1
                else
                {
                    global.trackListI = 0
                    ds_list_shuffle(global.trackList)
                }
            }
            
            track = ds_list_find_value(global.trackList,global.trackListI)
            time = string_format(global.yourTimes[track], 1, 3)
            delta = find_delta(time,track)
            delta = string_replace(delta,"%)","")
            delta = string_replace(delta,"(","")  
            found += 1
            if real(delta) > 0
                found = 0 
            if found > 10
                found = 0
        }
    }
    
        if ds_list_size(global.trackList) = 0
    {
        show_message("Please enter at least one time to use the random track feature")
        room_goto(rm_track_list)
        exit
    }
    
    if global.mode != "boss"
        obj_track.image_index = ds_list_find_value(global.trackList,global.trackListI)
    else
        obj_track.image_index = (ds_list_find_value(global.trackList,global.trackListI) - global.tracks) * 5
    
}
