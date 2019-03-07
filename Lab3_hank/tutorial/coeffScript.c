#include <stdio.h>
#include <stdlib.h>


void main(void){
    FILE *in_file = fopen("tut3_coeff","r");
    FILE *out_file = fopen("a","w");
    
    char ch;
    int index,val, check,status;

    while(ch!=EOF){
        ch = fgetc(in_file);
        if(ch != ' '){
            fprintf(out_file,"%c",ch);
        }
    }
    fclose(in_file);
    fclose(out_file);

    FILE *in_file2 = fopen("a","r");
    FILE *out_file2 = fopen("tut3_coeff2.txt","w");

    check = fscanf(in_file2,"coeff[%d]=%d;\n",&index,&val);
    fprintf(out_file2,"{");
    while(check > 0){
        printf("val = %d | check = %d\n",val,check);
        fprintf(out_file2,"assign coeff[%d]=%d;\n",index,val);
        check = fscanf(in_file2,"coeff[%d]=%d;\n",&index,&val);
    }

    fclose(in_file2);
    fclose(out_file2);
    status = remove("a");
}