module lab1part3_V3(
	input        CLOCK_50,
	input  [9:0] SW, 
	input        KEY3,
	output [6:0] HEX0
	);
	
	
	wire   [3:0] cntr4_out, cntr30_out,decoder_in;
	reg    [3:0] buffer;
	reg          press , enable4b , enable30b , reset4b , reset30b;
	assign       decoder_in[3:0] = buffer[3:0];
	
	
	cntr_4b           my_4bCntr  (press, reset4b,enable4b,cntr4_out[3:0]);
	cntr_30b          my_30bCntr (CLOCK_50, reset30b,enable30b,cntr30_out[3:0]);
	seven_seg_decoder decoder    (decoder_in[3:0], HEX0[6:0]);
	
	
	always @(*)
	begin
		case(SW[9:8])
			2'b00: begin						// disp val of SW[3:0] on HEX0[6:0]
				
				enable4b    <= 1'b0;
				enable30b   <= 1'b0;
				reset4b     <= KEY3;
				reset30b    <= KEY3;
				press       <= 1'b0;
				
				buffer[3:0] <= SW[3:0];

			end
			
			2'b01: begin						// 4bit cntr to 7seg decoder
				

				enable4b    <= 1'b1;
				enable30b   <= 1'b0;
				reset4b     <= 1'b0;
				reset30b    <= KEY3;
				press       <= KEY3;
				
				buffer[3:0] <= cntr4_out[3:0];
			
			end
			
			2'b10: begin						//30bit cntr to 7seg decoder
			

				enable4b    <= 1'b0;
				enable30b   <= 1'b1;
				reset4b     <= KEY3;
				reset30b    <= KEY3;
				press       <= 1'b0;
				
				
				buffer[3:0] <= cntr30_out[3:0];
			end
			
			2'b11: begin						// HEX0 off
				

				enable4b    <= 1'b0;
				enable30b   <= 1'b0;
				reset4b     <= KEY3;
				reset30b    <= KEY3;
				press       <= 1'b0;
				
				
				buffer[3:0] <= 4'b1111;
			end
			
		endcase
	end

endmodule 