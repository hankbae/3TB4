// This is the top-level file for lab 5 that connects the datapath and the control unit
module lab5 (
	input CLOCK_50,
	input [0:0] KEY,
	output [3:0] GPIO_0,
	output [9:0] LEDR,
	// testing
	output [7:0] RF_selected0 /*synthesis keep*/,
	output [7:0] RF_selected1 /*synthesis keep*/,
	output [7:0] RF_2out /*synthesis keep*/,
	output [7:0] RF_0out /*synthesis keep*/,
	output [7:0] RF_3out /*synthesis keep*/,
	output [7:0] Op1mux_out /*synthesis keep*/,
	output [7:0] Op2mux_out /*synthesis keep*/,
	output [7:0] PC_out /*synthesis keep*/,
	output [7:0] ALU_out /*synthesis keep*/,
	output [7:0] IM_Q /*synthesis keep*/,
	output [7:0] IE_out /*synthesis keep*/,
	output [1:0] WAS_out /*synthesis keep*/,
	output [7:0] RM_out /*synthesis keep*/,

	
	output br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause,
	output delay_done,
	output temp_is_positive, temp_is_negative, temp_is_zero,
	output register0_is_zero,

	output write_reg_file, result_mux_select,
	output [1:0] op1_mux_select, op2_mux_select,
	output start_delay_counter, enable_delay_counter,
	output commit_branch, increment_pc,
	output alu_add_sub, alu_set_low, alu_set_high,
	output load_temp_register, increment_temp_register, decrement_temp_register,
	output [1:0] select_immediate,
	output [1:0] select_write_address
	
	
	);

//wire br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause;
//wire delay_done;
//wire temp_is_positive, temp_is_negative, temp_is_zero;
//wire register0_is_zero;
//
//wire write_reg_file, result_mux_select;
//wire [1:0] op1_mux_select, op2_mux_select;
//wire start_delay_counter, enable_delay_counter;
//wire commit_branch, increment_pc;
//wire alu_add_sub, alu_set_low, alu_set_high;
//wire load_temp_register, increment_temp_register, decrement_temp_register;
//wire [1:0] select_immediate;
//wire [1:0] select_write_address;


wire clk;
wire reset_n;

//more wires
wire [3:0] stepper_signals;










assign clk=CLOCK_50;
assign reset_n=KEY[0];


// connect stepper signals to the green LEDs, so that we can observe them visually
assign LEDR[3:0] = stepper_signals;
assign GPIO_0[3:0]=stepper_signals;    //3.3V is enough to activate the SN754410 Half_H driver
// GPIO pins, from top, the 6th rows are 5V(left/inner) and GND(right/out side)
 

control_fsm the_control_fsm (
	.clk (clk),
	.reset_n (reset_n),
	// Status inputs
	.br (br),
	.brz (brz),
	.addi (addi),
	.subi (subi),
	.sr0 (sr0),
	.srh0 (srh0),
	.clr (clr),
	.mov (mov),
	.mova (mova),
	.movr (movr),
	.movrhs (movrhs),
	.pause (pause),
	.delay_done (delay_done),
	.temp_is_positive (temp_is_positive),
	.temp_is_negative (temp_is_negative),
	.temp_is_zero (temp_is_zero),
	.register0_is_zero (register0_is_zero),
	// Control signal outputs
	.write_reg_file (write_reg_file),
	.result_mux_select (result_mux_select),
	.op1_mux_select (op1_mux_select),
	.op2_mux_select (op2_mux_select),
	.start_delay_counter (start_delay_counter),
	.enable_delay_counter (enable_delay_counter),
	.commit_branch (commit_branch),
	.increment_pc (increment_pc),
	.alu_add_sub (alu_add_sub),
	.alu_set_low (alu_set_low),
	.alu_set_high (alu_set_high),
	.load_temp_register (load_temp_register),
	.increment_temp_register (increment_temp_register),
	.decrement_temp_register (decrement_temp_register),
	.select_immediate (select_immediate),
	.select_write_address (select_write_address)	
);

datapath the_datapath (
	.clk (clk),
	.reset_n (reset_n),
	// Control signals
	.write_reg_file (write_reg_file),
	.result_mux_select (result_mux_select),
	.op1_mux_select (op1_mux_select),
	.op2_mux_select (op2_mux_select),
	.start_delay_counter (start_delay_counter),
	.enable_delay_counter (enable_delay_counter),
	.commit_branch (commit_branch),
	.increment_pc (increment_pc),
	.alu_add_sub (alu_add_sub),
	.alu_set_low (alu_set_low),
	.alu_set_high (alu_set_high),
	.load_temp (load_temp_register),
	.increment_temp (increment_temp_register),
	.decrement_temp (decrement_temp_register),
	.select_immediate (select_immediate),
	.select_write_address (select_write_address),
	// Status outputs
	.br (br),
	.brz (brz),
	.addi (addi),
	.subi (subi),
	.sr0 (sr0),
	.srh0 (srh0),
	.clr (clr),
	.mov (mov),
	.mova (mova),
	.movr (movr),
	.movrhs (movrhs),
	.pause (pause),
	.delay_done (delay_done),
	.temp_is_positive (temp_is_positive),
	.temp_is_negative (temp_is_negative),
	.temp_is_zero (temp_is_zero),
	.register0_is_zero (register0_is_zero),
	// Motor control outputs
	.stepper_signals (stepper_signals),
	// Temporary outputs for debugging purposes
	.RF_selected0(RF_selected0),
	.RF_selected1(RF_selected1),
	.RF_2out(RF_2out),
	.RF_0out(RF_0out),
	.RF_3out(RF_3out),
	.Op1mux_out(Op1mux_out),
	.Op2mux_out(Op2mux_out),
	.PC_out(PC_out),
	.ALU_out(ALU_out),
	.IM_Q(IM_Q),
	.IE_out(IE_out),
	.WAS_out(WAS_out),
	.RM_out(RM_out)
);


endmodule
