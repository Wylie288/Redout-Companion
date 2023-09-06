///get_time(track, input)
track = argument0

safe = 0
minutes = 0

input = argument1
safe = 1

if string_pos(":", input) != 0
{
    minutes = real(string_char_at(input,0))
    input = string_replace(input, string_char_at(input,0), "");
    input = string_replace(input, ":", "");
}

        
 if (input = "") or (real(input) = 0)
    safe = -1

if safe != -1
{
    regex_setinput(input)
    regex_setexpression("^[0-9]\d{0,9}(\.\d{1,3})?%?$")
        
     if regex_search() = 0
        safe = -1
     if regex_search() = 1
        input = real(input) + (60 * minutes)
 }

ini_open(global.mode)
    if safe = 1
    {
        global.yourTimes[track] = real(input)
        ini_write_real(global.class,string(track),real(input))
        get_baseline()
    }
    else
    {
        show_message_async("Invalid Time")
    }
ini_close()
