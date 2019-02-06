module led_decoder(
	input [2:0] points
	output [4:0] LED
	);
	
	always @(points)
	begin
		case(points)
			3'b000: begin					//0 points
				LED[0] <= 1'b0;
				LED[1] <= 1'b0;
				LED[2] <= 1'b0;
				LED[3] <= 1'b0;
				LED[4] <= 1'b0;
			end
			
			3'b001: begin					//1 point
				LED[0] <= 1'b1;
				LED[1] <= 1'b0;
				LED[2] <= 1'b0;
				LED[3] <= 1'b0;
				LED[4] <= 1'b0;
			end
			
			3'b010: begin					//2 points
				LED[0] <= 1'b0;
				LED[1] <= 1'b1;
				LED[2] <= 1'b0;
				LED[3] <= 1'b0;
				LED[4] <= 1'b0;
			end
			
			3'b011: begin					//3 points
				LED[0] <= 1'b0;
				LED[1] <= 1'b0;
				LED[2] <= 1'b1;
				LED[3] <= 1'b0;
				LED[4] <= 1'b0;
			end
			
			3'b100: begin					//4 points
				LED[0] <= 1'b0;
				LED[1] <= 1'b0;
				LED[2] <= 1'b0;
				LED[3] <= 1'b1;
				LED[4] <= 1'b0;
			end
			
			3'b101: begin					//5 points
				LED[0] <= 1'b0;
				LED[1] <= 1'b0;
				LED[2] <= 1'b0;
				LED[3] <= 1'b1;
				LED[4] <= 1'b0;
			end
			
			default:							// ERROR (all on)
				LED[0] <= 1'b1;
				LED[1] <= 1'b1;
				LED[2] <= 1'b1;
				LED[3] <= 1'b1;
				LED[4] <= 1'b1;
			end
		endcase
	end
endmodule
