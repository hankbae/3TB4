module clock_divier(
	input Clock, Reset_n,
	input [20:0] divisor,
	output reg clk_ms
	);
	
	reg [20:0] cntr;
	
	
	always @(posedge Clock)
	begin
		if ((Reset_n == 0)|(cntr[20:0] >= divisor)) cntr[20:0] <= 20'd0;
		cntr[20:0] <= cntr[20:0] + 20'd1;
	end
	assign clk_ms = (cntr>divisor/2);
	
endmodule
