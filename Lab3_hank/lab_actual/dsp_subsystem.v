module dsp_subsystem (
	input sample_clock,
	input reset,
	input [1:0] selector,
	input [15:0] input_sample,
	output reg [15:0] output_sample
	);

//assign output_sample = input_sample;

wire [15:0] FIR_out;
wire [15:0] ECHO_out;


FIR50 (
	.clk(sample_clock),
	.signal_in(input_sample),
	//.taps(8'd161),
	.signal_out(FIR_out)
	);
	
shiftregister (
	.clock(sample_clock),
	.shiftin(input_sample),
	.shiftout(ECHO_out),
	.taps()
	);

always @(posedge sample_clock or posedge reset)
begin
	if (reset == 1'b1) output_sample <= input_sample;
	else
	begin
		case (selector)
			2'b0:  output_sample <= input_sample;	// straight passthrough // WORKS
			
			2'b1:	 output_sample <= FIR_out;			// FIR filter
			
			2'b10: output_sample <= input_sample + ECHO_out;		// Echo machine // WORKS
			
			default: output_sample <= input_sample; // straight passthrough // WORKS
		endcase
	end
end

endmodule
