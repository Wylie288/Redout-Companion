///Load
list = ds_list_create()

ini_open("event")
    
    //Class
    ds_list_clear(list)
    for (i=0;i<4;i++)
    {
        if ini_read_real("class",string(i),1)
            ds_list_add(list,i)
    }
    ds_list_shuffle(list)
    if ds_list_size(list) > 0
        class = ds_list_find_value(list,0)
    
    //Team
    ds_list_clear(list)
    for (i=0;i<7;i++)
    {
        if ini_read_real("team",string(i),1)
            ds_list_add(list,i)
    }
    ds_list_shuffle(list)
    if ds_list_size(list) > 0
        team = ds_list_find_value(list,0)
    
    //Mode
    ds_list_clear(list)
    for (i=0;i<11;i++)
    {
        if ini_read_real("mode",string(i),1)
            ds_list_add(list,i)
    }
    ds_list_shuffle(list)
    if ds_list_size(list) > 0
        mode = ds_list_find_value(list,0)
    
    //Laps
    ds_list_clear(list)
    if mode = 2
        laps = choose(1,2)
    if mode = 5
        laps = 99
    if mode = 10
        laps = 10
    if (mode = 0) or (mode = 1) or (mode = 4)
        laps = choose(2,3,4,6)
    if (mode = 3) or (mode = 6) or (mode = 7) or (mode = 9)
        laps = choose(2,3,4,5,6)
    if mode = 8
        laps = choose(3,4,5,6,7)
    
    //Track
    ds_list_clear(list)
    for (i=0;i<global.tracks/5;i++)
    {
        if i != 5 //Some events done have this lap
            if ini_read_real("world",string(i),1)
                for (j=0;j<5;j++)
                    ds_list_add(list,(i*5)+j)
    }
    ds_list_shuffle(list)
    if ds_list_size(list) > 0
        track = ds_list_find_value(list,0)
        
    //Active Power-ups
    ds_list_clear(list)
    for (i=0;i<6;i++)
    {
        if ini_read_real("A",string(i),1)
            ds_list_add(list,i)
    }
    ds_list_shuffle(list)
    if ds_list_size(list) > 0
        active = ds_list_find_value(list,0)
        
    //Passive Power-ups
    ds_list_clear(list)
    for (i=0;i<6;i++)
    {
        if ini_read_real("P",string(i),1)
            ds_list_add(list,i)
    }
    ds_list_shuffle(list)
    if ds_list_size(list) > 0
        passive = ds_list_find_value(list,0)
ini_close()

ds_list_destroy(list)
