//4-1 multiplexer

module mux(
	input D1,D2,D3,D4,
	input [1:0] sel,
	output reg Q
	);
	
	always @(*)
	begin
	
		case(sel)
			2'b00  : Q <= D1;
			2'b01  : Q <= D2;
			2'b10  : Q <= D3;
			2'b11  : Q <= D4;
			default: Q <= Q;
		endcase
		
	end	
	
endmodule
