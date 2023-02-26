


total = 0
global.baseline = 0
if global.mode = "boss"
    ini_open("race")
else
    ini_open(global.mode)
for (i=0; i<global.tracks+(global.tracks/5); i++)
{
    if i = global.tracks
        ini_open("boss")
    global.yourTimes[i] = ini_read_real(global.class,string(i),0)
    if (global.yourTimes[i] > 0) && (i <global.tracks) 
    {
        global.baseline += (global.yourTimes[i]/global.tracktimes[i,0])
        total += 1
    }
}
if total != 0
global.baseline /= total
else
global.baseline = 0

ini_close()
