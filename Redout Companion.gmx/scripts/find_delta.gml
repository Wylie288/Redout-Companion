if global.mode != "boss"
{
    drawtime = argument0
    track = argument1
    
    //Delta Calc
    target = global.tracktimes[track,0] * global.baseline
    baseline = (real(drawtime)/global.tracktimes[track,0])
    if global.decimal = 1
        delta = round((100 - (real(drawtime)/target * 100))*10) /-10
    if global.decimal = 0
        delta = round(100 - (real(drawtime)/target * 100)) * -1
    
    //Deta Format
    if (delta < -0.5) && (delta >= -3)
        draw_set_color(make_color_rgb(100,255,100))
    else if (delta < -3)
        draw_set_color(make_color_rgb(0,255,0))
    else if (delta > 0.5) && (delta <= 3)
        draw_set_color(make_color_rgb(255,100,100))
    else if delta > 3
        draw_set_color(make_color_rgb(255,0,0))
    else
        draw_set_color(c_white)
        
    draw_set_halign(fa_left)
    //Deta Return
    if real(drawtime) > 0
    {
        if global.decimal = 1
            return ("(" + string_format(delta,2,1) + "%)")
        if global.decimal = 0
            return ("(" + string(delta) + "%)")
    }
    else
        return ""
}

if global.mode = "boss"
{
    drawtime = argument0
    target = argument1
    
    //Delta Calc
   // baseline = (real(drawtime)/global.tracktimes[track,0])
    delta = round(100 - (real(drawtime)/target * 100)) * -1
    
    //Deta Format
    if (delta < 0) && (delta >= -3)
        draw_set_color(make_color_rgb(100,255,100))
    else if (delta < -3)
        draw_set_color(make_color_rgb(0,255,0))
    else if (delta > 0) && (delta <= 3)
        draw_set_color(make_color_rgb(255,100,100))
    else if delta > 3
        draw_set_color(make_color_rgb(255,0,0))
    else
        draw_set_color(c_white)
        
    draw_set_halign(fa_left)
    //Deta Return
    if real(drawtime) > 0
        return ("(" + string(delta) + "%)")
    else
        return ""
}
