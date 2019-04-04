module clk_div (input clk, reset_n, input [18:0] prescaler, output reg [18:0]counter);
//counts every 1/100 of a second
//50MHz/100 = 500,000

always @(posedge clk) 
begin
	if(~reset_n) counter<=19'b0;
	else
	begin
		if(counter==prescaler) counter<=0;
		else counter<=counter+1;
	end
end
endmodule
