module light(
	input clk, on,
	output reg A, B, C
	);
	
	reg [1:0] light_state;
	
	
	always @(posedge clk or posedge on)
	begin
		if (on == 1'b1) begin
		
			case (light_state)
				2'b01: begin
					A <= 1'b1;
					B <= 1'b0;
					C <= 1'b0;
					light_state <= 2'b10;
				end
				
				2'b10: begin
					A <= 1'b1;
					B <= 1'b1;
					C <= 1'b0;
					light_state <= 2'b11;
				end
				
				2'b11: begin
					A <= 1'b1;
					B <= 1'b1;
					C <= 1'b1;
					light_state <= 2'b01;
				end
				
				default: begin
					A <= 1'b0;
					B <= 1'b0;
					C <= 1'b0;
				end
			endcase
		end else begin
			A <= 1'b0;
			B <= 1'b0;
			C <= 1'b0;
			//light_state <= 2'b00;
		end
	end
endmodule 