//clock divider
module clock_divider (input CLOCK_50, Reset_n, output clk_ms);

reg[27:0] counter = 28'd0;
parameter DIVISOR = 28'd2;

always @(posedge CLOCK_50)
begin
	counter <= counter + 28'd1;
	if(Reset_n) counter <= 28'd0;
	if(counter>=(DIVISOR-1))
		counter <= 28'd0;
end

assign clk_ms = (counter<DIVISOR/2)?1'b0:1'b1;

endmodule
