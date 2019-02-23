module dsp_subsystem {
	input sample_clock,
	input reset,
	input [1:0] selector,
	input [15:0] input_sample,
	output reg [15:0] output_sample
	);

//assign output_sample = input_sample;

assign @( posedge sample_clock or posedge reset)
begin

if (reset == 1'b1) output_sample <= input_sample;
else
begin


end


end



endmodule
