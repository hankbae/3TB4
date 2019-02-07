module add_point(
	input press,
	output reg [2:0] points
	);

	always @(posedge press)
	begin
		points <= points +3'b1;
	end
endmodule
