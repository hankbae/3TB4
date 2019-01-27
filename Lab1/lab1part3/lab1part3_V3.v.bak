module lab1part3(
	input CLOCK_50,
	input [9:0] SW, 
	input KEY3,
	output [6:0] HEX0
	);
	
	
	wire [3:0] cntr4_out, cntr30_out;
	reg [3:0] x;
	reg press , enable4b , enable30b , reset4b , reset30b;
	
//	HEX0[6:0] <= 6'b1;						// init state of HEX0 off
	
	
	always @(SW[9:0])
	begin
		case(SW[9:8])
			2'b00: begin						// disp val of SW[3:0] on HEX0[6:0]
				
				enable4b <= 1'b0;
				enable30b <= 1'b0;
				reset4b <= KEY3;
				reset30b <= KEY3;
				press <= 1'b0;
				
				x[3:0] <= SW[3:0];

			end
			
			2'b01: begin						// 4bit cntr to 7seg decoder
				

				enable4b <= 1'b1;
				enable30b <= 1'b0;
				reset4b <= 1'b0;
				reset30b <= KEY3;
				press <= KEY3;
				
				x[3:0] <= cntr4_out[3:0];
			
			end
			
			2'b10: begin						//30bit cntr to 7seg decoder
			

				enable4b <= 1'b0;
				enable30b <= 1'b1;
				reset4b <= KEY3;
				reset30b <= KEY3;
				press <= 1'b0;
				
				
				x[3:0] <= cntr30_out[3:0];
			end
			
			2'b11: begin						// HEX0 off
				

				enable4b <= 1'b0;
				enable30b <= 1'b0;
				reset4b <= KEY3;
				reset30b <= KEY3;
				press <= 1'b0;
				
				
				x[3:0] <= 4'b1;
			end
			
		endcase
	end
//----------------------------30 bit counter-----------------------------------------

	reg [29:0] cntr30;
	
	always @(posedge CLOCK_50)
	begin
	if (reset30b) 
		cntr30[29:0] <= 30'b0;
	else if (enable30b)
		cntr30[29:0] <= cntr30[29:0] + 30'b1;
	
	end
	assign cntr30_out[3:0] = cntr30[29:26];


//----------------------------4 bit counter-----------------------------------------
	reg [3:0] cntr4;
	
	always @(posedge press)
	begin
	if (reset4b) 
		cntr4[3:0] <= 4'b0;
	else if (enable4b)
		cntr4[3:0] <= cntr4[3:0] + 4'b1;
	
	end
	assign cntr4_out[3:0] = cntr4[3:0];
	

//----------------------------7 segment decoder-----------------------------------------

	reg [6:2] top_5_seg;
	
	assign HEX0[0] = (~x[3]&~x[2]&~x[1]&x[0]) | (x[2]&~x[1]&~x[0]) | (x[3]&x[1]&~x[0]) | (x[3]&x[2]);
	assign HEX0[1] = (x[3]&x[2]&x[1]) | (x[3]&x[2]&~x[0]) | (x[2]&x[1]&~x[0]) | (x[3]&x[1]&~x[0]) | (~x[3]&x[2]&~x[1]&x[0]);
	assign HEX0[6:2] = top_5_seg[6:2];
	
	always @(x[3:0])
	begin
	
		case(x[3:0])
			4'b0000: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b1;
			end

			4'b0001: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b1;
			end
			
			4'b0010: begin
				top_5_seg[2] <= 1'b1;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b0011: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b0100: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b0101: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b0110: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
				
			4'b0111: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b1;
			end
			
			4'b1000: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b1001: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
			
			4'b1010: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
				
			4'b1011: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end

			4'b1100: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b0;
			end
				
			4'b1101: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
				
			4'b1110: begin
				top_5_seg[2] <= 1'b0;
				top_5_seg[3] <= 1'b0;
				top_5_seg[4] <= 1'b0;
				top_5_seg[5] <= 1'b0;
				top_5_seg[6] <= 1'b0;
			end
				
			4'b1111: begin
				top_5_seg[2] <= 1'b1;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b1;
			end
			
			default: begin
				top_5_seg[2] <= 1'b1;
				top_5_seg[3] <= 1'b1;
				top_5_seg[4] <= 1'b1;
				top_5_seg[5] <= 1'b1;
				top_5_seg[6] <= 1'b1;
			end
			
		endcase
		
	end 
	
	
	
	
endmodule 