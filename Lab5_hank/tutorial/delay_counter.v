module delay_counter (input clk, reset_n, start, enable, input [7:0] delay, output reg done);
parameter BASIC_PERIOD=19'd2;   // can change this value to make delay longer, originally 500000
//clockspeed=50MHz

reg [7:0] mydelay;
wire [18:0] counter;

clk_div msec10(clk,reset_n,BASIC_PERIOD, counter);

always @(posedge clk)
begin

	if(reset_n == 1'b0)
	begin
		mydelay	<= 8'b0;
		done		<= 1'b1;
	end else 
	begin
		if(start) mydelay<=delay;
		else
		if(enable)
		begin
			if (counter == 19'b0)
			begin
				if(mydelay == 8'b0) done <=1'b1;
				else
				begin
					mydelay <= mydelay - 8'b1;
					done <=1'b0;
				end
			end
		end
	end
end


endmodule
