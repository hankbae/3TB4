// ************************************* DONE *******************************************
// ************************************ TESTED ******************************************
module alu (input add_sub, set_low, set_high, input [7:0] operanda , operandb, output reg [7:0] result);

always @(add_sub or set_low or set_high)
begin

	if(set_low == 1'b1) result <= {operanda[7:4],operandb[3:0]};
	else if (set_high == 1'b1) result <= {operandb[3:0], operanda[3:0]};
	else
	begin
		if(add_sub == 1'b1) result <= operanda + operandb;
		else result <= operanda - operandb;
	end
end

endmodule
