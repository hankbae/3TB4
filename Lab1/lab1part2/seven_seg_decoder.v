module seven_seg_decoder(
	input [3:0] x,
	output [6:0] hex_LEDs
	);
	
	reg [6:2] top_5_seg;
	
	assign hex_LEDs[0] = (~x[3]&~x[2]&~x[1]&x[0]) | (x[2]&~x[1]&~x[0]) | (x[3]&x[1]&~x[0]) | (x[3]&x[2]);
	assign hex_LEDs[1] = (x[3]&x[2]&x[1]) | (x[3]&x[2]&~x[0]) | (x[2]&x[1]&~x[0]) | (x[3]&x[1]&~x[0]) | (~x[3]&x[2]&~x[1]&x[0]);
	assign hex_LEDs[6:2] = top_5_seg[6:2];
	
	always @(x[3:0])
	begin
	
		case(x[3:0])
			4'b0000: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b1;
			end

			4'b0001: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b1;
			end
			
			4'b0010: begin
				top_5_seg[2] <= 1'b1;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b0011: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b0100: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b0101: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b0110: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
				
			4'b0111: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b1;
			end
			
			4'b1000: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b1001: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b1010: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
				
			4'b1011: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end

			4'b1100: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b0;
			end
				
			4'b1101: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
				
			4'b1110: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
				
			4'b1111: begin
				top_5_seg[2] <= 1'b1;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b1;
			end
			
			default: begin
				top_5_seg[2] <= 1'b1;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b1;
			end
			
		endcase
		
	end 
	
endmodule 