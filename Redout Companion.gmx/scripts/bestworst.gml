//Best
best_delta = 9999999
best_track = 0
worst_delta = -9999999
worst_track = 0
i = 0

repeat(global.tracks)
{
    time = real(string_format(global.yourTimes[i], 1, 3))
    target = global.tracktimes[i,0] * global.baseline
    baseline = (real(time)/global.tracktimes[i,0])
    delta = round((100 - (real(time)/target * 100))*10) /-10
    //Best
    if (delta < best_delta) && (time > 0)
    {
        best_delta = delta
        best_track = i
    }
    //Worst
    if (delta > worst_delta) && (time > 0)
    {
        worst_delta = delta
        worst_track = i
        show_debug_message("worst")
    }
    i += 1
}

show_debug_message(global.trackNames[best_track])
show_debug_message(global.trackNames[worst_track])
