#define color_json
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
file = file_text_open_read(fileName)
    while (!file_text_eof(file))    {
        jsonRaw += file_text_read_string(file)
        file_text_readln(file)
    }
file_text_close(file)

jsonMap = json_decode(jsonRaw)

if (jsonMap[? "success"] = 1)   {
    resetInventory()
    descriptionsList = jsonMap[? "descriptions"] //Descriptions/names for each possible inventory item
    assetsList = jsonMap[? "assets"] //Users inventory items
    nameMap = ds_map_create()
    for (var i = 0; i < ds_list_size(descriptionsList); i++)    {
        description = descriptionsList[| i] //List Accessor
        classId = description[? "classid"] //Hash Map Accessor
        nameMap[? classId] = description[? "name"]
    }
    ds_map_destroy(descriptionsList)
    for (var i = 0; i < ds_list_size(assetsList); i++)  {
        asset = assetsList[| i]
        classId = asset[? "classid"]
        name = nameMap[? classId]      
        if (string_pos("-", name) != 0 )    { //Livery: "WILD - CONQUEROR CLASS III"
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
        else    { //Color: "Golden Lime"
            colorId = colorMap[? name]
            writeColor(colorId)
        }
    }
    ds_map_destroy(assetsList)
    ds_map_destroy(nameMap)
    room_goto(rm_colors)
}
else    {
    show_message_async("Inventory Sync Failed")
    show_debug_message("JSON recieved, success != 0")
}

#define writeLivery
ini_open("livery_count")
    count = ini_read_real(string(classId),string(liveryId + shipId),0)
    ini_write_real(string(classId),string(liveryId + shipId),count + 1)
ini_close()

#define writeColor
ini_open("Color")
    count = ini_read_real("color", string(colorId) ,0)
    ini_write_real("color", string(colorId), count + 1)
ini_close()

#define resetInventory
reset_color()
reset_livery()