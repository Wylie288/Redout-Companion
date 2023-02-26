for (c=0; c<4; c+=1)
    for (n=0; n<48; n+=1)
    {
        ini_open("livery_count")
            ini_write_real(string(c),string(n),0)
        ini_close()
        
        ini_open("livery_trade")
            ini_write_string(string(c),string(n),"·")
        ini_close()
    }
