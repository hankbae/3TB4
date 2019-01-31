module lab2tut (
	input 		 CLOCK_50,
	input  [2:0] KEY,
	output [19:0] disp_num,
	output [6:0] HEX0,
					 HEX1,
					 HEX2,
					 HEX3,
					 HEX4,
					 HEX5
	);

	wire clk;
	wire [19:0] prescaler;
	assign prescaler = 10'd4;
	
	clock_divider(CLOCK_50,KEY[0],prescaler,clk);		//	prescaling clock
	hex_counter(clk,KEY[0],KEY[1],KEY[2],disp_num);		// counting clock pulses
	num_decoder(disp_num[3:0],HEX0);
	num_decoder(disp_num[7:4],HEX1);
	num_decoder(disp_num[11:8],HEX2);
	num_decoder(disp_num[15:12],HEX3);
	num_decoder(disp_num[19:16],HEX4);
endmodule 