module hex_counter_Nathan(
	input 				Clock,
							Reset_n,
							Start_n,
							Stop_n,
	output reg [19:0] Q
	);
	
	reg resume; //resume 1 is on
	
	
	always @(posedge Clock)
	begin
		if (Reset_n == 1'b0) Q <= 20'b0; //if reset pressed, set Q to 0
		else begin
																	//1 is unpressed, 0 is pressed
			if (Start_n == 1'b0) resume <= 1'b1;		//using blocking here
			else if (Stop_n == 1'b0) resume <= 1'b0;	//using blocking here
			
			if (resume == 1'b1) Q <= Q + 20'b1;
			else Q <= Q;
			end
		
	end
endmodule 