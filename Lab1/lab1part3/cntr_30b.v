module cntr_30b(
	input clk,R,E,
	output [3:0] out
	//output [29:0] cntr
	);
	
	reg [29:0] cntr;
	assign out[3:0] = cntr[29:26];
	
		

	
	always @(posedge clk)
	begin
		case(R)
			1'b1: cntr[29:0] <= cntr[29:0] + 30'b1;
			1'b0: cntr[29:0] <= 30'b0;
			default: cntr[29:0] <= cntr[29:0] + 30'b1;
		endcase
		
//		cntr[29:0] <= cntr[29:0] + 30'b1;
	end
	
	
endmodule 