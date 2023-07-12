#define color_jsonOld
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
    show_debug_message(string(string_pos('total_inventory_count', text)))
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

#define color_json
//WILD - CONQUEROR CLASS III

colorMap = ds_map_create()
liveryMap = ds_map_create()
shipMap = ds_map_create()
classMap = ds_map_create()
for (var i = 0; i < colorListSize; i++)
    ds_map_add(colorMap, colorList[i], i)
for (var i = 0; i < liveryListSize; i++)
    ds_map_add(liveryMap, liveryList[i], i*6)
for (var i = 0; i < shipListSize; i++)
    ds_map_add(shipMap, shipList[i], i)
for (var i = 0; i < classListSize; i++)
    ds_map_add(classMap, classList[i], i)

jsonRaw = "";    
file = file_text_open_read("json")
    while (!file_text_eof(file)){
        jsonRaw += file_text_read_string(file)
        file_text_readln(file)
    }
file_text_close(file)

jsonMap = json_decode(jsonRaw)

if jsonMap[? "success"] = 1{
    resetInventory()

    descriptionsList = jsonMap[? "descriptions"] //Descriptions/names for each possible inventory item
    assetsList = jsonMap[? "assets"] //Users inventory items
    nameMap = ds_map_create()
    
    for (var i = 0; i < ds_list_size(descriptionsList); i++){
        description = descriptionsList[| i] //List Accessor
        classId = description[? "classid"] //Hash Map Accessor
        nameMap[? classId] = description[? "name"]    
    }
    
    for (var i = 0; i < ds_list_size(assetsList); i++){
        asset = assetsList[| i]
        classId = asset[? "classid"]
        name = nameMap[? classId]
        
        if (string_pos("-", name) != 0) { //Livery: "WILD - CONQUEROR CLASS III"
            dashPosition = string_pos("-", name)
            classPosition = string_pos("CLASS", name)
            nameLength = string_length(name)
            livery = stringSub(name, 1, dashPosition-2)
            ship = stringSub(name, dashPosition+2, classPosition-2)
            class = stringSub(name, classPosition+6, nameLength)
            liveryId = liveryMap[? livery]
            shipId = shipMap[? ship]
            classId = classMap[? class]
            writeLivery(liveryId, shipId, classId)
        }
        else { //Color: "Golden Lime"
            colorId = colorMap[? name]
            writeColor(colorId)
        }
        
        room_goto(rm_colors)
    }
}
else
{
    show_message("Inventory Sync Failed")
    show_debug_message("JSON recieved, success != 0")
}

#define writeLivery
ini_open("livery_count")
    count = ini_read_real(string(classNum),string(liveryNum + shipNum),0)
    ini_write_real(string(classNum),string(liveryNum + shipNum),count + 1)
ini_close()

#define writeColor
ini_open("Color")
    count = ini_read_real("color", string(color) ,0)
    ini_write_real("color", string(color), count + 1)
ini_close()

#define resetInventory
reset_color()
reset_livery()