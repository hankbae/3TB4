module lab1part3_V1(
	input CLOCK_50,
	input [9:0] SW,
	input KEY3,
	output [6:0] HEX0
	);
	
	reg [3:0] cntr4_out, cntr30_out;
	wire True, False;
	assign True = 1'b1;
	assign False = 1'b0;
	
	//HEX0[6:0] <= 6'b1;						// init state of HEX0 off
	
	
	always @(SW[9:0])
	begin
		case(SW[9:8])
			2'b00: begin						// disp val of SW[3:0] on HEX0[6:0]
				
				cntr_30b  my_30bCntr(CLOCK_50,KEY3,False,cntr30_out[3:0]);	// resets cntr to 0
				cntr_4b   my_4bCntr(False,KEY3,False,cntr4_out[3:0]);	// resets cntr to 0
				
				seven_seg_decoder my_decoder(SW[3:0],HEX0[6:0]);
			end
			
			2'b01: begin						// 4bit cntr to 7seg decoder
				
				cntr_30b my_30bCntr(CLOCK_50 , KEY3 , False , cntr30_out[3:0]);	// resets cntr to 0
				cntr_4b my_4bCntr  (KEY3     , False , True , cntr4_out[3:0] );	// counts KEY3 presses
				
				seven_seg_decoder my_decoder(cntr4_out[3:0],HEX0[6:0]);
			
			end
			
			2'b10: begin						//30bit cntr to 7seg decoder
			
				cntr_30b my_30bCntr(CLOCK_50 , KEY3 , True , cntr30_out[3:0]);	// resets cntr to 0
				cntr_4b my_4bCntr  (False     , KEY3 , False , cntr4_out[3:0] );	// counts KEY3 presses
				
				seven_seg_decoder my_decoder(cntr30_out[3:0],HEX0[6:0]);
			end
			
			2'b11: begin 						// displays nothing
				
				cntr_30b my_30bCntr(CLOCK_50 , KEY3 , False , cntr30_out[3:0]);	// resets cntr to 0
				cntr_4b my_4bCntr  (False     , KEY3 , False , cntr4_out[3:0] );	// counts KEY3 presses
				
				seven_seg_decoder my_decoder(4'1111,HEX0[6:0]);
			end
			
		endcase
	
	end
	
	
	
endmodule 