module Q3(
	input [7:0] x, // Q1.7 format
	input [7:0] y, // Q2.6 format
	input [7:0] z, // Q0.8 format
	output [16:0] w //Q2.15 format
);

wire [16:0] x_tmp;
wire [16:0] z_tmp;

wire [16:0] x_s;
wire [16:0] y_s;
wire [16:0] z_s;

wire [16:0] mul1;
wire [16:0] mul2;

// expanding all to 17 bits
assign x_tmp[16:9] = x;
assign z_tmp[16:9] = z;


// coverting to Q2.15
assign x_s = x_tmp >>> 1;
assign y_s[16:9] = y;
assign z_s = z_tmp >>> 2;

multiply mul_1(
	.dataa(x_s),
	.datab(y_s),
	.result(mul1)
	);
	
multiply mul_2(
	.dataa(y_s),
	.datab(z_s),
	.result(mul2)
	);

assign w = mul1 + mul2 + x_s + y_s + z_s;

endmodule
