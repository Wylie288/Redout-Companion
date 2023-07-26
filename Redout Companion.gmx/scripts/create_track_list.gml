///Create Tracklist
if room = rm_random
{
    if global.above_target = 1
    {
        ini_open(global.mode)
        ds_list_clear(global.trackList)
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
        }
        
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
    }
    if global.above_target = 0
    {
        global.trackListI = 0
        ds_list_clear(global.trackList)
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
    if global.mode != "boss"
        obj_track.image_index = ds_list_find_value(global.trackList,global.trackListI)
    else
        obj_track.image_index = (ds_list_find_value(global.trackList,global.trackListI) - global.tracks) * 5
    
}
