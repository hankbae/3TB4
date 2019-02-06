module bin2BCD(
	input [19:0] bin,
	output [23:0] BCD
	);
	
   reg [4:0] i;
	reg [43:0] tmp;
	
	
   
   always @(bin)
   begin
      // Clear previous number and store new number in tmp register
      tmp[43:20] = 44'b0;
      tmp[19:0] = bin;
      
      // Loop 20 times
      for (i=5'b0; i<5'b10100; i=i+5'b1) begin
         if (tmp[23:20] >= 4'b101) tmp[23:20] = tmp[23:20] + 4'b11;
            
         if (tmp[27:24] >= 4'b101) tmp[27:24] = tmp[27:24] + 4'b11;
            
         if (tmp[31:28] >= 4'b101) tmp[31:28] = tmp[31:28] + 4'b11;
			
			if (tmp[35:32] >= 4'b101) tmp[35:32] = tmp[35:32] + 4'b11;
			
			if (tmp[39:36] >= 4'b101) tmp[39:36] = tmp[39:36] + 4'b11;
			
			if (tmp[43:40] >= 4'b101) tmp[43:40] = tmp[43:40] + 4'b11;
         
         // tmp entire register left once
         tmp = tmp << 1;
      end
	end
	assign BCD = tmp[43:20];
	
endmodule
