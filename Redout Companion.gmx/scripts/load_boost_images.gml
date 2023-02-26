with obj_track_guide_control
{
    i = 0
    repeat(10)
    {
        i += 1
        if global.boostn_array[i] != spr_loading
            sprite_delete(global.boostn_array[i])
        global.boostn_array[i] = spr_loading
    }
    pic_loaded = 0
    if global.boostn[global.track] > 0
        http_pic = http_get_file(global.guide_url[global.track,pic_loaded],"Temp.png")
}
