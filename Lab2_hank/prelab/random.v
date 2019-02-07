module random(
	input clk,
			reset_n,
	output reg [14:0] random,
	output reg rnd_ready
	);
	
	initial
	begin
		random <= 15'b10101000011011; // arbitrary inital state
	end
	
	always @(posedge clk or negedge reset_n)
	begin
		if (reset_n ==1'b0) random <= 15'b10101000011011;  // arbitrary inital state
		else
		begin
			// fibonacci LFSR w/ taps on [13],[4],[2][0]
			random[14] = random[13];
			random[13] = random[12];
			random[12] = random[11];
			random[11] = random[10];
			random[10] = random[9];
			random[9] = random[8];
			random[8] = random[7];
			random[7] = random[6];
			random[6] = random[5];
			random[5] = random[4];
			random[4] = random[3];
			random[3] = random[2];
			random[2] = random[1];
			random[1] = random[0];
			random[0] = random[0] ^ (random[2] ^ (random[4] ^ random[13]));
			

			if ((random >= 15'd10)&&(random <= 15'd50)) rnd_ready = 1'b1;  // 1000 <= random <= 5000
			else rnd_ready = 1'b0;
		end
	end
endmodule
