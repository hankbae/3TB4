module lab2part1(
	input CLOCK_50,
	input KEY0,
	output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5
	);

	reg [14:0] disp_val;
	wire [14:0] disp_buff;
	wire [23:0] BCD;
	wire clk,clk_tmp,rng_ready;
	
	
	clock_divider msec(CLOCK_50,KEY0,20'd50000,clk_tmp);
	clock_divider sec(clk_tmp,KEY0,20'd1000,clk);
	
	random RNG(clk,KEY0,disp_buff,rng_ready);
	bin2BCD bcd(disp_buff,BCD);
	
	num_decoder hex0(CLOCK_50,1'b0,KEY0,BCD[3:0],HEX0);
	num_decoder hex1(CLOCK_50,1'b0,KEY0,BCD[7:4],HEX1);
	num_decoder hex2(CLOCK_50,1'b0,KEY0,BCD[11:8],HEX2);
	num_decoder hex3(CLOCK_50,1'b0,KEY0,BCD[16:12],HEX3);
	num_decoder hex4(CLOCK_50,1'b0,KEY0,BCD[19:16],HEX4);
	num_decoder hex5(CLOCK_50,1'b0,KEY0,BCD[23:20],HEX5);
	
	
	always @(posedge CLOCK_50 or posedge rng_ready)
	begin
		if (rng_ready == 1'b1) disp_val <= disp_buff;
	end 
endmodule
