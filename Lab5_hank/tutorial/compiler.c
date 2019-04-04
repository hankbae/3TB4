#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define ERR(error) perror(error); exit(0);

FILE *in_file;
FILE * out_file;
char dec_out[8];
char reg_out[8];
int counter;


void appendchar(const char * dest, int c)
{
    size_t len = strlen(dest);
    char *str2 = malloc(len + 1 + 1 ); /* one for extra char, one for trailing zero */
    strcpy(str2, dest);
    str2[len] = c;
    str2[len + 1] = '\0';
    free( str2 );
}
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
    char operand[10];
    char str1[10],str2[10];
    char output[10];
    char fileName[64];
    int int1;
    char tmp;
    
    
    printf("file name: 3tlab5.txt\n");
    // strcpy(fileName,"3tlab5.txt");
    // printf("file name: ");
    // if (scanf("%s",fileName)<=0){ERR("scanf");}

    in_file = fopen("3tlab5.txt","r");
    out_file = fopen("outfile.txt","w");

    counter = 0;
    printf("counter = %d\n",counter);
    while((tmp = fgetc(in_file))!=EOF){
        printf("tmp = %c\n",tmp);
        if((tmp == ' ')|| (tmp == ',')) {counter =1;printf("counter = %d\n",counter);}
        
        if(counter <= 0){appendchar(operand,tmp);printf("operand = %s\n",operand);}
        else if (counter <= 1)
        {
            printf("operand = %s\n",operand);
            if(strcmp(operand,"BR")==0)
            {
                strcpy(output,"100");
                fscanf(in_file,"%d\n",int1);
                printf("int1 = %d\n",int1);
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
                printf("int1 = %d\n",int1);
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
                fscanf(in_file,"%s, %d\n",str1,int1);
                printf("str1 = %s\n",str1);
                printf("int1 = %d\n",int1);
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
                fscanf(in_file,"%s, %d\n",str1,int1);
                printf("str1 = %s\n",str1);
                printf("int1 = %d\n",int1);
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
                printf("int1 = %d\n",int1);
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
                printf("int1 = %d\n",int1);
                if(int1 <= 1){strcat(output,"000");}
                else if(int1 <= 3){strcat(output,"00");}
                else if(int1 <= 7){strcat(output,"0");}
                dec2bin(int1);
                strcat(output,dec_out);
            }
            else if(strcmp(operand,"CLR")==0)
            {
                strcpy(output,"011000");
                fscanf(in_file,"%s\n",str1);
                printf("str1 = %s\n",str1);
                reg2bin(str1);
                strcat(output,reg_out);
            }
            else if(strcmp(operand,"MOV")==0)
            {
                printf("operand = %s\n",operand);
                strcpy(output,"0111");
                fscanf(in_file,"%s, str2\n",str1,str2);
                printf("str1 = %s\n",str1);
                printf("str2 = %s\n",str2);
                reg2bin(str1);
                strcat(output,reg_out);
                reg2bin(str2);
                strcat(output,reg_out);
            }
            else if(strcmp(operand,"MOVA")==0)
            {
                strcpy(output,"110000");
                fscanf(in_file,"%s\n",str1);
                printf("str1 = %s\n",str1);
                reg2bin(str1);
                strcat(output,reg_out);
            }
            else if(strcmp(operand,"MOVR")==0)
            {
                strcpy(output,"110001");
                fscanf(in_file,"%s\n",str1);
                printf("str1 = %s\n",str1);
                reg2bin(str1);
                strcat(output,reg_out);
            }
            else if(strcmp(operand,"MOVRHS")==0)
            {
                strcpy(output,"110010");
                fscanf(in_file,"%s\n",str1);
                printf("str1 = %s\n",str1);
                reg2bin(str1);
                strcat(output,reg_out);
            }
            else if(strcmp(operand,"PAUSE")==0)
            {
                strcpy(output,"00000000");
            }

            counter = 0;
            strcpy(operand,"");
            fprintf(out_file,"%s\n",output);
        }
        // printf("%s == SR0 => %d\n",operand,strcmp(operand,"SR0"));

    }
    fclose(in_file);
    fclose(out_file);
}