module branch_logic (input [7:0] register0, output reg branch);
	always@(register0)
		if (register0 == 8'b00000000)
		branch=1;
		else 
		branch=0;


endmodule
