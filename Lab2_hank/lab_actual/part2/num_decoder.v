module num_decoder (
	input 			clk,
						flashing,
						off,
	input  [3:0] 	number,
	output reg [6:0] disp
	);
	
	wire clk_1Hz;
	
	clock_divider clk_flashing(clk,1'b1,20'd500,clk_1Hz);  // divisor is originally 20'd100000
	
	always @(posedge clk)
	begin
		if (off == 1'b1) disp <= 7'b1111111;
		else if (flashing==1'b1)
		begin
			case(clk_1Hz)
				1'b1: disp <=7'b0;
				1'b0: disp <=7'b1111111;
			endcase
		end else
		begin 
			case(number)
				4'b0000: begin					//0
					disp[0] <= 1'b0;	//ON
					disp[1] <= 1'b0;	//ON
					disp[2] <= 1'b0;	//ON
					disp[3] <= 1'b0;	//ON
					disp[4] <= 1'b0;	//ON
					disp[5] <= 1'b0;	//ON
					disp[6] <= 1'b1;
				end

				4'b0001: begin					//1
					disp[0] <= 1'b1;
					disp[1] <= 1'b0;	//ON
					disp[2] <= 1'b0;	//ON
					disp[3] <= 1'b1;
					disp[4] <= 1'b1;
					disp[5] <= 1'b1;
					disp[6] <= 1'b1;
				end
				
				4'b0010: begin					//2
					disp[0] <= 1'b0;	//ON
					disp[1] <= 1'b0;	//ON
					disp[2] <= 1'b1;
					disp[3] <= 1'b0;	//ON
					disp[4] <= 1'b0;	//ON
					disp[5] <= 1'b1;
					disp[6] <= 1'b0;	//ON
				end
				
				4'b0011: begin					//3
					disp[0] <= 1'b0;	//ON
					disp[1] <= 1'b0;	//ON
					disp[2] <= 1'b0;	//ON
					disp[3] <= 1'b0;	//ON
					disp[4] <= 1'b1;
					disp[5] <= 1'b1;
					disp[6] <= 1'b0;	//ON
				end
				
				4'b0100: begin					//4
					disp[0] <= 1'b1;
					disp[1] <= 1'b0;	//ON
					disp[2] <= 1'b0;	//ON
					disp[3] <= 1'b1;
					disp[4] <= 1'b1;
					disp[5] <= 1'b0;	//ON
					disp[6] <= 1'b0;	//ON
				end
				
				4'b0101: begin					//5
					disp[0] <= 1'b0;	//ON
					disp[1] <= 1'b1;
					disp[2] <= 1'b0;	//ON
					disp[3] <= 1'b0;	//ON
					disp[4] <= 1'b1;
					disp[5] <= 1'b0;	//ON
					disp[6] <= 1'b0;	//ON
				end
				
				4'b0110: begin					//6
					disp[0] <= 1'b0;	//ON
					disp[1] <= 1'b1;
					disp[2] <= 1'b0;	//ON
					disp[3] <= 1'b0;	//ON
					disp[4] <= 1'b0;	//ON
					disp[5] <= 1'b0;	//ON
					disp[6] <= 1'b0;	//ON
				end
					
				4'b0111: begin					//7
					disp[0] <= 1'b0;	//ON
					disp[1] <= 1'b0;	//ON
					disp[2] <= 1'b0;	//ON
					disp[3] <= 1'b1;
					disp[4] <= 1'b1;
					disp[5] <= 1'b1;
					disp[6] <= 1'b1;
				end
				
				4'b1000: begin					//8
					disp[0] <= 1'b0;	//ON
					disp[1] <= 1'b0;	//ON
					disp[2] <= 1'b0;	//ON
					disp[3] <= 1'b0;	//ON
					disp[4] <= 1'b0;	//ON
					disp[5] <= 1'b0;	//ON
					disp[6] <= 1'b0;	//ON
				end
				
				4'b1001: begin					//9
					disp[0] <= 1'b0;	//ON
					disp[1] <= 1'b0;	//ON
					disp[2] <= 1'b0;	//ON
					disp[3] <= 1'b0;	//ON
					disp[4] <= 1'b1;
					disp[5] <= 1'b0;	//ON
					disp[6] <= 1'b0;	//ON
				end
							
				default: begin					//NULL
					disp[0] <= 1'b1;
					disp[1] <= 1'b1;
					disp[2] <= 1'b1;
					disp[3] <= 1'b1;
					disp[4] <= 1'b1;
					disp[5] <= 1'b1;
					disp[6] <= 1'b1;
				end
			endcase
		end
	end
endmodule 