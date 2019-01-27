//4-bit counter w/ reset & enable

module cntr_4b(
	input  R,E,clk,
	output [3:0] Q
	);
	
	reg    [3:0] cntr;
	
	always @(posedge clk)
	begin
	
		if (R==1'b1)
			cntr[3:0] <= 4'b0;
		else
		
			if (E==1'b1)
				cntr[3:0] <= cntr[3:0] + 4'b1;
			else
				cntr[3:0] <= cntr[3:0];
	end
	
	assign Q[3:0] = cntr[3:0];
	
endmodule

	