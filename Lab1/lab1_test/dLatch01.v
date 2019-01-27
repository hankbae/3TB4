//DLatch w/enable

module dLatch01(
	input      D, E,
	output reg Q,
	output     QBar
	);
	
	always @(E)
	begin
		if (E == 1'b1)
			Q<=D;
	end	
	assign QBar = ~Q;
	
endmodule
	