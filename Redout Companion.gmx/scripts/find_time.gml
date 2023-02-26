drawtime = argument0
draw_set_color(c_white)
//Find Parts
minutes = floor(real(drawtime) / 60)
seconds = real(string_format(real(drawtime) - (minutes * 60),4,3))
mili = ((seconds * 1000) - (floor(seconds)* 1000))

//Find milliseconds
if mili >= 100
    mili = string(floor(mili))
else if mili >= 10
    mili = "0"+string(floor(mili))
else
    mili = "00"+string(floor(mili))

//Return Time
if (real(drawtime) >= 60) && (seconds >= 10)
    return string(string(minutes) + ":" + string(floor(seconds)) + "." + string(mili))
else if real(drawtime) > 60
    return string(string(minutes) + ":0" + string(floor(seconds)) + "." + string(mili))
else if real(drawtime) > 0
    return (drawtime)

//N/A
if real(drawtime) = 0
{
        draw_set_halign(fa_center)
        draw_set_color(c_white)
        return ("N/A")
}
