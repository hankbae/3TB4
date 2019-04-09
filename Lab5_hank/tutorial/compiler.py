def num2bin(val,bits):
    if val > 0:
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
        writeline = "100" + (5-len(tmp)) * "0"+tmp +"\n"
    elif line[0] == "BRZ":
        tmp = num2bin(int(line[1]),5)
        writeline = "101" + (5-len(tmp))*"0" + tmp + "\n"
    elif line[0] == "ADDI":
        tmp = num2bin(int(line[2]),3)
        writeline = "000" + (3-len(tmp))*"0" + tmp + reg2bin(line[1]) + "\n"
    elif line[0] == "SUBI":
        tmp = num2bin(int(line[2]),3)
        writeline = "001" + (3-len(tmp))*"0" + tmp + reg2bin(line[1]) + "\n"
    elif line[0] == "SR0":
        tmp = num2bin(int(line[1]),4)
        writeline = "0100" + (4-len(tmp))*"0" + tmp + "\n"
    elif line[0] == "SRH0":
        tmp = num2bin(int(line[1]),4)
        writeline = "0101" + (4-len(tmp))*"0" + tmp + "\n"
    elif line[0] == "CLR":
        writeline = "011000"+ reg2bin(line[1]) + "\n"
    elif line[0] == "MOV":
        writeline = "0111" + reg2bin(line[1]) + reg2bin(line[2]) + "\n"
    elif line[0] == "MOVA":
        writeline = "110000"+ reg2bin(line[1]) + "\n"
    elif line[0] == "MOVR":
        writeline = "110001"+ reg2bin(line[1]) + "\n"
    elif line[0] == "MOVRHS":
        writeline = "110010"+ reg2bin(line[1]) + "\n"
    elif line[0] == "PAUSE":
        writeline = 8*"1"+"\n"
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
    outfile = open(filename[:-4]+"_out.txt","w")
    line = 1
    while line != ['']:
        line = infile.readline()
        line = str2line(line)
        print(line)
        writeline = line2bin(line)
        print(writeline)
        outfile.write(writeline)
    outfile.close()
    infile.close()

main()
