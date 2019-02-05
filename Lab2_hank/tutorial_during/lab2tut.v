module lab2tut (
	input 		 CLOCK_50,
	input  [2:0] KEY,
//	output [19:0] disp_num,
	output [6:0] HEX0,
					 HEX1,
					 HEX2,
					 HEX3,
					 HEX4,
					 HEX5
	);
	
	wire clk;
	wire [43:0] BCD;
	wire [19:0] prescaler,num;
	assign prescaler = 20'd4;
	
	
	
	clock_divider msec_clock(CLOCK_50,KEY[0],prescaler,clk);		//	prescaling clock
	hex_counter cntr(clk,KEY[0],KEY[1],KEY[2],num);		// counting clock pulses
	bin2BCD display_val(num,BCD);
	
	num_decoder hex0(BCD[3:0],HEX0);
	num_decoder hex1(BCD[7:4],HEX1);
	num_decoder hex2(BCD[11:8],HEX2);
	num_decoder hex3(BCD[15:12],HEX3);
	num_decoder hex4(BCD[19:16],HEX4);
	num_decoder hex5(BCD[23:20],HEX5);
	

endmodule 