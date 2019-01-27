//DFF w/ low reset & low enable

module dff_lowResetLowEnable(
	input      D, clk, R, E,
	output reg Q,
	output     QBar
	);
	
	always @(posedge clk)
	begin
		if (R == 1'b0)
			Q<=1'b0;
		else if (E == 1'b0)
			Q <= D;
	end
	
	assign QBar = ~Q;
	
endmodule
