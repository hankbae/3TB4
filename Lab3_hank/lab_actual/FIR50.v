module FIR50(
	input clk,
	input [15:0] signal_in,
	//input [7:0] taps,
	output [15:0] signal_out
	);
	

reg [15:0] delay [14:0]; // delay registers
wire [15:0] result [14:0]; // taps after coeff mul
//reg [31:0] sum;
genvar i;
integer j,k;
//wire tap_interval = 8'd161/taps;


wire [15:0] coeff [14:0];

assign signal_out = result[0] + result[1] + result[2]+ result[3]+ result[4]+ result[5]+ result[6]+ result[7]+ result[8]+ result[9]+ result[10]+ result[11]+ result[12]+ result[13]+ result[14];
	

// -------- COEFFICIENTS -------------
// ask TA about writing array in 1 line

assign coeff[0]=0;
assign coeff[1]=1940;
assign coeff[2]=0;
assign coeff[3]=-1110;
assign coeff[4]=0;
assign coeff[5]=1270;
assign coeff[6]=0;
assign coeff[7]=8660;
assign coeff[8]=0;
assign coeff[9]=1270;
assign coeff[10]=0;
assign coeff[11]=-1110;
assign coeff[12]=0;
assign coeff[13]=1940;
assign coeff[14]=0;


// -----------------------------------

generate
	for(i = 0; i<=14; i=i+1) begin: mul_loop
		multiplier (delay[i],coeff[i],result[i]);
	end
endgenerate

always @(posedge clk)
begin
	delay[0] <= signal_in;
	
	for(j=0;j<=13;j = j + 1) delay[j+1]<=delay[j]; // delay line
	
//	for(k=0;k<=14;k = k + 1) // summing scaled tapped lines
//	begin
////		if (k%tap_interval == 8'd0)
////		begin
//			
////		end
//	end
end
	
endmodule 