module add_point(
	input press,
	output reg [2:0] points
	);

	always @(posedge press)
	begin
		if (points > 3'd5) points <= 3'b1;
		else points <= points +3'b1;
	end
endmodule
