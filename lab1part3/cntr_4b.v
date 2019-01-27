module cntr_4b(
	input press,R,E,
	output [3:0] res
	);
	
	reg [3:0] cntr;
	assign res[3:0] = cntr[3:0];
	
	always @(posedge press)
	begin
		if (R) 
			cntr[3:0] <= 4'b0;
		else if (E)
			cntr[3:0] <= cntr[3:0] + 4'b1;
		
		end
	
endmodule 