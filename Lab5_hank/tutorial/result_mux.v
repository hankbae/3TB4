module result_mux (
	input select_result,
	input [7:0] alu_result,
	output reg [7:0] result
);

always@(select_result)
	case (select_result)
		1'b0: result= alu_result;
		1'b1: result= 8'b00000000;
	endcase	



endmodule
