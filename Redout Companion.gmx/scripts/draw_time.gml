drawx = argument0
drawy = argument1
drawtime = argument2
target = argument3
//Find Parts
minutes = floor(real(drawtime) / 60)
seconds = real(drawtime) - (minutes * 60)
mili = (seconds * 1000 - floor(seconds)* 1000)
//Find milliseconds
if mili >= 100
    mili = string(floor(mili))
else if mili >= 10
    mili = "0"+string(floor(mili))
else
    mili = "00"+string(floor(mili))

if target = 0
{
    //Draw Time
    if real(drawtime) >= 70
        draw_text(drawx,drawy,string(minutes) + ":" + string(floor(seconds)) + "." + string(mili))
    else if real(drawtime) > 60
        draw_text(drawx,drawy,string(minutes) + ":0" + string(seconds))
    else if real(drawtime) > 0
        draw_text(drawx,drawy,drawtime)
    
    //Delta Calc
    baseline = (real(drawtime)/global.tracktimes[track,0])
    delta = round((global.baseline-baseline) * -100)
    
    //Deta Color
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
    //Deta Color
    draw_set_halign(fa_left)
    if real(drawtime) > 0
        draw_text(drawx+18,drawy,"(" + string(delta) + "%)")
        
    //N/A Draw
    if real(drawtime) = 0
    {
        draw_set_halign(fa_center)
        draw_set_color(c_white)
        draw_text(drawx,drawy,"N/A")
    }
}

if target = 1
{
    if real(drawtime) >= 70
        return (string(minutes) + ":" + string(floor(seconds)) + "." + string(mili))
    else if real(drawtime) > 60
        return (string(minutes) + ":0" + string(seconds))
    else if real(drawtime) > 0
        return (drawtime)
    else
        return "N/A"
}
