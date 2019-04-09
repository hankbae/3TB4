// ************************************* DONE *******************************************
module temp_register (input clk, reset_n, load, increment, decrement, input [7:0] data,
					output reg negative, positive, zero);

reg [7:0] temp;
					
always @(posedge clk)
begin
	if (reset_n == 1'b0) temp = 8'b0;
	else
	begin
		if (load == 1'b1) 	  temp = data;
		if (increment == 1'b1) temp = temp + 8'b1;
		if (decrement == 1'b1) temp = temp - 8'b1;
	
		if (temp == 8'b0)		// zero
		begin
			negative = 1'b0;
			positive =	1'b0;
			zero 		= 1'b1;
		end else if (temp > 8'b0 && temp <= 8'b111111) // positive
		begin
			negative = 1'b0;
			positive =	1'b1;
			zero 		= 1'b0;
		end else
		begin						// negative
			negative = 1'b1;
			positive =	1'b0;
			zero 		= 1'b0;
		end
	end
end
endmodule
