//1 bit data DFF

module DFlipFlop(
	input  D, clk,
	output reg Q
	);
	
	always @(posedge clk) Q = D; 
	
endmodule
