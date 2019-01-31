//counter
module hex_counter(input Clock, Reset_n, Start_n, Stop_n, output reg [19:0] Q);


always@ (posedge Clock)
begin

	case(~Stop_n)
		1'b0:begin
			if(~Reset_n) Q <= 20'b1;
			if(~Start_n) Q<= Q + 20'b1;
			end
		1'b1:begin
			if(~Reset_n) Q<= 20'b0;
		   end
	endcase
		


end



endmodule
