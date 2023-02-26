///Break file down
file = file_text_open_read("json");
text = "";
while (!file_text_eof(file))
{
    text += file_text_read_string(file);
    file_text_readln(file);
}
file_text_close(file);

//Check File
if (string_pos("total_inventory_count", text) != 0) and (string_pos('"total_inventory_count": 0', text) = 0)
{    
    show_debug_message(string(string_pos('"total_inventory_count": 0', text)))
    global.text_map = json_decode(text)
    
    desc = ds_map_find_value(global.text_map, "descriptions")
    assets = ds_map_find_value(global.text_map, "assets")
    totalassets = ds_list_size(assets);
    totaldesc = ds_list_size(desc);
    
    //Check iventory count
    
    //Count
    reset_color()
    reset_livery()
    global.counts = ds_map_create()
    for (var i = 0; i < totalassets; i++)
    {
        asset_Entry = ds_list_find_value(assets, i);
        classid = asset_Entry[? "classid"];
        
        //Find Name
        for (var j = 0; j < totaldesc; j++)
        {   
            desc_Entry = ds_list_find_value(desc, j);
            if desc_Entry[? "classid"] = classid
            {
                name = desc_Entry[? "name"]
                break
            }
        }
        
        //Write to file
        k = 0
        if string_pos("CLASS", name) = 0
        {
            repeat(21)
            {
                //Color
                if global.color[k] = name
                {
                    ini_open("Color")
                        count = ini_read_real("color",string(k),0)
                        ini_write_real("color",string(k),count + 1)
                    ini_close()
                    break
                }
                k += 1
            }
        }
        else
        {
            if string_pos("CAMO", name) != 0
                n = 0
            if string_pos("DANGER", name) != 0
                n = 6
            if string_pos("FRACTURE", name) != 0
                n = 12
            if string_pos("FRAGMENT", name) != 0
                n = 18
            if string_pos("MECHA", name) != 0
                n = 24
            if string_pos("VINE", name) != 0
                n = 30
            if string_pos("WILD", name) != 0
                n = 36
            if string_pos("ZEPHYR", name) != 0
                n = 42
                
            if string_pos("ESA", name) != 0
                n += 0
            if string_pos("KOENIGG", name) != 0
                n += 1
            if string_pos("SULHA", name) != 0
                n += 2
            if string_pos("CONQUEROR", name) != 0
                n += 3
            if string_pos("ASERA", name) != 0
                n += 4
            if string_pos("LUNARE", name) != 0
                n += 5
                
            if string_pos("I", name) != 0
                c = 0
            if string_pos("II", name) != 0
                c = 1
            if string_pos("III", name) != 0
                c = 2
            if string_pos("IV", name) != 0
                c = 3
                
            ini_open("livery_count")
            count = ini_read_real(string(c),string(n),0)
            ini_write_real(string(c),string(n),count + 1)
            ini_close()
        }
        room_goto(rm_colors)
    }
}
else
show_message("Could not get inventory!")
