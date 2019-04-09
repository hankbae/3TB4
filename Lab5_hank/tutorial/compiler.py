def num2bin(val,bits):
    if val >= 0:
        tmp = bin(val)
        return tmp[2:]
    else:
        tmp = -1*val
        tmp = bin(tmp-(1<<bits))
        return tmp[3:]
    

def reg2bin(string):
    if string == "R0":
        return("00")
    elif string == "R1":
        return("01")
    elif string == "R2":
        return("10")
    elif string == "R3":
        return("11")
    else:
        return(-1)

def line2bin(line):
    if line[0] == "BR":
        tmp = num2bin(int(line[1]),5)
        writeline = "100" + (5-len(tmp)) * "0"+tmp
    elif line[0] == "BRZ":
        tmp = num2bin(int(line[1]),5)
        writeline = "101" + (5-len(tmp))*"0" + tmp
    elif line[0] == "ADDI":
        tmp = num2bin(int(line[2]),3)
        writeline = "000" + (3-len(tmp))*"0" + tmp + reg2bin(line[1])
    elif line[0] == "SUBI":
        tmp = num2bin(int(line[2]),3)
        writeline = "001" + (3-len(tmp))*"0" + tmp + reg2bin(line[1])
    elif line[0] == "SR0":
        tmp = num2bin(int(line[1]),4)
        writeline = "0100" + (4-len(tmp))*"0" + tmp
    elif line[0] == "SRH0":
        tmp = num2bin(int(line[1]),4)
        writeline = "0101" + (4-len(tmp))*"0" + tmp
    elif line[0] == "CLR":
        writeline = "011000"+ reg2bin(line[1])
    elif line[0] == "MOV":
        writeline = "0111" + reg2bin(line[1]) + reg2bin(line[2])
    elif line[0] == "MOVA":
        writeline = "110000"+ reg2bin(line[1])
    elif line[0] == "MOVR":
        writeline = "110001"+ reg2bin(line[1])
    elif line[0] == "MOVRHS":
        writeline = "110010"+ reg2bin(line[1])
    elif line[0] == "PAUSE":
        writeline = 8*"1"
    else:
        writeline = ""
    return(writeline)

def str2line(line):
    line = line.strip("\n")
    line = line.split(" ")
    line2 = []
    for i in line:
        i = i.split(",")
        for j in i:
            if j != '':
                line2.append(j)
    if line2 != []:
        line = line2
    return(line)

def main():
    filename = input("file name:")
    infile = open(filename,"r")
    outfile = open("instruction_rom.mif","w")
    ## header of file
    outfile.write("-- Copyright (C) 2017  Intel Corporation. All rights reserved.\n")
    outfile.write("-- Your use of Intel Corporation's design tools, logic functions \n")
    outfile.write("-- and other software and tools, and its AMPP partner logic \n")
    outfile.write("-- functions, and any output files from any of the foregoing \n")
    outfile.write("-- (including device programming or simulation files), and any \n")
    outfile.write("-- associated documentation or information are expressly subject \n")
    outfile.write("-- to the terms and conditions of the Intel Program License \n")
    outfile.write("-- Subscription Agreement, the Intel Quartus Prime License Agreement,\n")
    outfile.write("-- the Intel FPGA IP License Agreement, or other applicable license\n")
    outfile.write("-- agreement, including, without limitation, that your use is for\n")
    outfile.write("-- the sole purpose of programming logic devices manufactured by\n")
    outfile.write("-- Intel and sold by Intel or its authorized distributors.  Please\n")
    outfile.write("-- refer to the applicable agreement for further details.\n\n")
    outfile.write("-- Quartus Prime generated Memory Initialization File (.mif)\n\n")
    outfile.write("WIDTH=8;\nDEPTH=256;\n\n")
    outfile.write("ADDRESS_RADIX=UNS;\nDATA_RADIX=BIN;\n\n")
    outfile.write("CONTENT BEGIN\n")
##    outfile.write("\t0    :   00000000;\n")
    # content
    line = infile.readline()
    cntr = 0
    while line != '':
        if line[0] != "#":
            line = str2line(line)
            print(line)
            writeline = line2bin(line)
            print(writeline)
            outfile.write("\t"+str(cntr)+(5-len(str(cntr)))*" "+":   "+writeline+";\n")
            cntr+=1
        line = infile.readline()
    outfile.write("\t["+str(cntr)+"..255]  :   11111111;\n")
    outfile.write("END;\n")
    outfile.close()
    infile.close()

main()
