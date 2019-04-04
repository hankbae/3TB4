#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define ERR(msg) perror(msg);exit(0);

FILE *in_file;
FILE * out_file;
char dec_out[8];
char reg_out[8];

void dec2bin(int val){
    int rem;
    int next = val;
    char tmp;

    strcpy(dec_out,00000000);
    while (next != 0){
        rem = next%2;
        tmp = rem+'0';
        strcat(dec_out,&tmp);
        next /= 2;
    }
}

void reg2bin(const char * reg){
    if (strcmp(reg,"R0"))     {strcpy(reg_out,"00");}
    else if(strcmp(reg,"R1")) {strcpy(reg_out,"01");}
    else if(strcmp(reg,"R2")) {strcpy(reg_out,"10");}
    else if(strcmp(reg,"R3")) {strcpy(reg_out,"11");}
}

void main(void){
    char operand[8];
    char str1[8];
    char str2[8];
    char output[9];
    char str[128];
    int int1,int2;
    
    printf("file name: ");
    if (scanf("%s",str)<=0){ERR("scanf");}

    in_file = fopen(str,"r");
    out_file = fopen("outfile.txt","w");
    
    
    char ch;
    int index,val, check,status;
    
    while(fscanf(in_file,"%s ",operand)!=EOF){
        printf("operand = %s\n",operand);
        if(strcmp(operand,"BR")==0)
        {
            strcpy(output,"100");
            fscanf(in_file,"%d\n",int1);
            if(int1 <= 1){strcat(output,"0000");}
            else if(int1 <= 3){strcat(output,"000");}
            else if(int1 <= 7){strcat(output,"00");}
            else if(int1 <= 15){strcat(output,"0");}
            dec2bin(int1);
            strcat(output,dec_out);
        }
        else if(strcmp(operand,"BRZ")==0)
        {
            strcpy(output,"101");
            fscanf(in_file,"%d\n",int1);
            if(int1 <= 1){strcat(output,"0000");}
            else if(int1 <= 3){strcat(output,"000");}
            else if(int1 <= 7){strcat(output,"00");}
            else if(int1 <= 15){strcat(output,"0");}
            dec2bin(int1);
            strcat(output,dec_out);
        } 
        else if(strcmp(operand,"ADDI")==0)
        {
            strcpy(output,"000");
            fscanf(in_file,"%s, %d",str1,int1);
            if(int1 <= 1){strcat(output,"00");}
            else if(int1 <= 3){strcat(output,"0");}
            dec2bin(int1);
            strcat(output,dec_out);
            reg2bin(str1);
            strcat(output,reg_out);
        }
        else if(strcmp(operand,"SUBI")==0)
        {
            strcpy(output,"001");
            fscanf(in_file,"%s, %d",str1,int1);
            if(int1 <= 1){strcat(output,"00");}
            else if(int1 <= 3){strcat(output,"0");}
            dec2bin(int1);
            strcat(output,dec_out);
            reg2bin(str1);
            strcat(output,reg_out);
        }
        else if(strcmp(operand,"SR0")==0)
        {
            strcpy(output,"0100");
            fscanf(in_file,"%d\n",int1);
            if(int1 <= 1){strcat(output,"000");}
            else if(int1 <= 3){strcat(output,"00");}
            else if(int1 <= 7){strcat(output,"0");}
            dec2bin(int1);
            strcat(output,dec_out);
        }
        else if(strcmp(operand,"SRH0")==0)
        {
            strcpy(output,"0101");
            fscanf(in_file,"%d\n",int1);
            if(int1 <= 1){strcat(output,"000");}
            else if(int1 <= 3){strcat(output,"00");}
            else if(int1 <= 7){strcat(output,"0");}
            dec2bin(int1);
            strcat(output,dec_out);
        }
        else if(strcmp(operand,"CLR")==0)
        {
            strcpy(output,"011000");
            fscanf(in_file,"%s",str1);
            reg2bin(str1);
            strcat(output,reg_out);
        }
        else if(strcmp(operand,"MOV")==0)
        {
            printf("operand = %s\n",operand);
            strcpy(output,"0111");
            fscanf(in_file,"%s, %s",str1,str2);
            reg2bin(str1);
            strcat(output,reg_out);
            reg2bin(str2);
            strcat(output,reg_out);
        }
        else if(strcmp(operand,"MOVA")==0)
        {
            strcpy(output,"110000");
            fscanf(in_file,"%s",str1);
            reg2bin(str1);
            strcat(output,reg_out);
        }
        else if(strcmp(operand,"MOVR")==0)
        {
            strcpy(output,"110001");
            fscanf(in_file,"%s",str1);
            reg2bin(str1);
            strcat(output,reg_out);
        }
        else if(strcmp(operand,"MOVRHS")==0)
        {
            strcpy(output,"110010");
            fscanf(in_file,"%s",str1);
            reg2bin(str1);
            strcat(output,reg_out);
        }
        else if(strcmp(operand,"PAUSE")==0)
        {
            strcpy(output,"00000000");
        }
        fprintf(out_file,"%s\n",output);
    }
    fclose(in_file);
    fclose(out_file);
}