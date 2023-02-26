for (c=0; c<4; c+=1)
    for (n=0; n<48; n+=1)
    {
        ini_open("livery_count")
            i = ini_read_real(string(c),string(n),0)
        ini_close()
        
        ini_open("livery_trade")
            if i = 0
                ini_write_string(string(c),string(n),"W")
            if i = 1
                ini_write_string(string(c),string(n),"·")
            if i > 1
                ini_write_string(string(c),string(n),"T")
        ini_close()
    }
