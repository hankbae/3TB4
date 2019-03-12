module Q1(
	input clk,
	input in,
	input reset,
	output reg out
	);

reg [3:0] state;	// init state is 4'b101
	
always@(posedge clk or posedge reset)
begin
	if(reset == 1'b1)
	begin
		out <= 1'b0;
		state <= 4'b101;
	end
	else
	begin
		case(state)
			4'b1110:	begin								// 1 zero
				out <= 1'b0;
				if(in == 1'b0) state <= 4'b1100;
				else state <= 4'b1;
			end
			
			4'b1100:	begin								// 2 zeros
				out <= 1'b0;
				if(in == 1'b0) state <= 4'b1000;
				else state <= 4'b1;
			end
			
			4'b1000:	begin								// 3 zeros
				out <= 1'b0;
				if(in == 1'b0) state <= 4'b0;
				else state <= 4'b1;
			end
			
			4'b0:		begin								// 4 zeros
				out <= 1'b1;
				if(in == 1'b0) state <= 4'b0;
				else state <= 4'b1;
			end
			
			4'b1:		begin								// 1 one
				out <= 1'b0;
				if(in == 1'b0) state <= 4'b1110;
				else state <= 4'b11;
			end
			
			4'b11:	begin								// 2 ones
				out <= 1'b0;
				if(in == 1'b0) state <= 4'b1110;
				else state <= 4'b111;
			
			end
			
			4'b111:	begin								// 3 ones
				out <= 1'b0;
				if(in == 1'b0) state <= 4'b1110;
				else state <= 4'b1111;
			
			end
			
			4'b1111:	begin								// 4 ones
				out <= 1'b1;
				if(in == 1'b0) state <= 4'b1110;
				else state <= 4'b1111;
			
			end
			
			default:	begin								// init
				out <= 1'b0;
				if(in == 1'b0) state <= 4'b1110;
				else state <= 4'b1;
			
			end
		endcase
	end
end
endmodule
