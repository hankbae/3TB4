module num_decoder (
	input  [3:0] number,
	output reg [6:0] disp
	);
	
	always @(number)
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
			
			4'b1010: begin					//A
				disp[0] <= 1'b0;	//ON
				disp[1] <= 1'b0;	//ON
				disp[2] <= 1'b0;	//ON
				disp[3] <= 1'b1;
				disp[4] <= 1'b0;	//ON
				disp[5] <= 1'b0;	//ON
				disp[6] <= 1'b0;	//ON
			end
			
			4'b1011: begin					//B
				disp[0] <= 1'b1;
				disp[1] <= 1'b1;
				disp[2] <= 1'b0;	//ON
				disp[3] <= 1'b0;	//ON
				disp[4] <= 1'b0;	//ON
				disp[5] <= 1'b0;	//ON
				disp[6] <= 1'b0;	//ON
			end
			
			4'b1100: begin					//C
				disp[0] <= 1'b0;	//ON
				disp[1] <= 1'b1;
				disp[2] <= 1'b1;
				disp[3] <= 1'b0;	//ON
				disp[4] <= 1'b0;	//ON
				disp[5] <= 1'b0;	//ON
				disp[6] <= 1'b1;
			end
			
			4'b1101: begin					//D
				disp[0] <= 1'b1;
				disp[1] <= 1'b0;	//ON
				disp[2] <= 1'b0;	//ON
				disp[3] <= 1'b0;	//ON
				disp[4] <= 1'b0;	//ON
				disp[5] <= 1'b1;
				disp[6] <= 1'b0;	//ON
			end
			
			4'b1110: begin					//E
				disp[0] <= 1'b0;	//ON
				disp[1] <= 1'b1;
				disp[2] <= 1'b1;
				disp[3] <= 1'b0;	//ON
				disp[4] <= 1'b0;	//ON
				disp[5] <= 1'b0;	//ON
				disp[6] <= 1'b0;	//ON
			end
			
			4'b1111: begin					//F
				disp[0] <= 1'b0;	//ON
				disp[1] <= 1'b1;
				disp[2] <= 1'b1;
				disp[3] <= 1'b1;
				disp[4] <= 1'b0;	//ON
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
endmodule 