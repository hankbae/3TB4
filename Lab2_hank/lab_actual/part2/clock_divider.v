module clock_divider(
	input Clock, Reset_n,
	input [19:0] divisor,
	output clk_ms
	);
	
	reg [19:0] cntr;
	
	always @(posedge Clock)
	begin
	
		if ((Reset_n==1'b0)||(cntr >= (divisor-20'b1))) cntr[19:0] <= 20'd0;
		else cntr[19:0] <= cntr[19:0] + 20'd1;
		
	end
	assign clk_ms = (cntr[19:0]>=(divisor/2))?1'b1:1'b0;
	
endmodule
