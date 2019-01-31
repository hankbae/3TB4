module clock_divider(
	input Clock, Reset_n,
	input [20:0] divisor,
	output clk_ms
	);
	
	reg [20:0] cntr;
	
	always @(posedge Clock)
	begin
		if ((Reset_n==1'b0)||(cntr >= (divisor-1'b1))) cntr[20:0] <= 21'd0;
		else cntr[20:0] <= cntr[20:0] + 21'd1;
	end
	assign clk_ms = (cntr[20:0]>(divisor/2))?1'b1:1'b0;
	
endmodule
