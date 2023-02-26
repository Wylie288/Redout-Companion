ini_open("Color")
for (i=0; i<21; i+=1)
{
    ini_write_real("color",string(i),0)
    ini_write_real("trade",string(i),0)
}
ini_close()
