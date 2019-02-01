module ass1(
	input clk, reset,left, right,
	output LA, LB, LC, RA, RB, RC
	);
	
	//All trigers are highs
	
	reg L,R;


	light right_light(clk,R,RA,RB,RC);
	light left_light(clk,L,LA,LB,LC);
	
	always @(posedge clk or posedge reset)
	begin
		
		if (reset) begin
			L <= 1'b0;
			R <= 1'b0;
		end else begin
			if (left == 1'b1) begin
				L <= 1'b1;
				R <= 1'b0;
			end else if (right == 1'b1) begin
				L <= 1'b0;
				R <= 1'b1;
			end
		end
	end
	
endmodule 