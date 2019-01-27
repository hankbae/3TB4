//DFF w/ low reset

module dff_lowReset(
	input      D, clk, R,
	output reg Q,
	output     QBar
	);
	
	always @(posedge clk)
	begin
		if (R == 1'b0)
			Q<=1'b0;
		else
			Q<=D;
	end
	
	assign QBar = ~Q;
	
endmodule
