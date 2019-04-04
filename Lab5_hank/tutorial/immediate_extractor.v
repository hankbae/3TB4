module immediate_extractor (input [7:0] instruction, input [1:0] select, output reg [7:0] immediate);

always@(select)
	case (select)
		2'b00: immediate= instruction[4:2];		//3bit instruction
		2'b01: immediate= instruction[3:0];		//4bit instruction
		2'b10:											//5bit instruction
		begin
		immediate[4:0]= instruction[4:0];
		immediate[5]=instruction[4];
		immediate[6]=instruction[4];
		immediate[7]=instruction[4];
		end
		2'b11: immediate= 8'b00000000;			//MOV instruction
	endcase	


endmodule
