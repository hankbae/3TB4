module led_decoder(
	input [2:0] points,
	input 		enable,
	output reg [4:0] LED
	);
	
	always @(points or enable)
	begin
		if (enable == 1'b1)
		begin
			case(points)
				3'b000:  LED <= 5'b0;			// 0 points
				3'b001:  LED <= 5'b1;			// 1 point
				3'b010:  LED <= 5'b11;			// 2 points
				3'b011:  LED <= 5'b111;			// 3 points
				3'b100:  LED <= 5'b1111;		// 4 points
				3'b101:  LED <= 5'b11111;		// 5 points
				default:	LED <= 5'b10101;		// ERROR (alternating
			endcase
		end else
			LED <= 5'b0;
	end
endmodule
