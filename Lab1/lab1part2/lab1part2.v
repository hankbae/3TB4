module lab1part2(
	input [3:0] SW,
	output [6:0] HEX0
	);
	
	reg [6:2] top_5_seg;
	
	assign HEX0[0] = (~SW[3]&~SW[2]&~SW[1]&SW[0]) | (SW[2]&~SW[1]&~SW[0]) | (SW[3]&SW[1]&~SW[0]) | (SW[3]&SW[2]);
	assign HEX0[1] = (SW[3]&SW[2]&SW[1]) | (SW[3]&SW[2]&~SW[0]) | (SW[2]&SW[1]&~SW[0]) | (SW[3]&SW[1]&~SW[0]) | (~SW[3]&SW[2]&~SW[1]&SW[0]);
	assign HEX0[6:2] = top_5_seg[6:2];
	
	always @(SW[3:0])
	begin
	
		case(SW[3:0])
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