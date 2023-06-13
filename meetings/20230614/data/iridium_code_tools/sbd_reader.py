import struct

with open('sbd_example3.sbd', 'rb') as f:
    msg = f.readline()
    print("raw message",msg)
    header_sub_fmt = 'cBHIdd' #ecosub encoding
    tup_decoded = struct.unpack(header_sub_fmt, msg[:struct.calcsize(header_sub_fmt)])
    f.close()
    print ("decoded message", tup_decoded)
    print("Lat",tup_decoded[4],"Lon", tup_decoded[5])

