module hex_counter(
	input 				Clock,
							Reset_n,
							Start_n,
							Stop_n,
	output reg [19:0] Q
	);
	
	reg resume;
	
	
	always @(posedge Clock)
	begin
		if (Reset_n == 1'b1) begin
			if (Start_n == 1'b0) resume <= 1'b1;			//using blocking here
			else if (Stop_n == 1'b0) resume <= 1'b0;	//using blocking here
			
			if (resume == 1'b1) Q <= Q + 20'b1;
			else Q <= Q;
		end else Q <= 20'b0;
	end
endmodule 