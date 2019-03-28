module datapath (input clk, reset_n,
				// Control signals
				input write_reg_file, result_mux_select,
				input [1:0] op1_mux_select, op2_mux_select,
				input start_delay_counter, enable_delay_counter,
				input commit_branch, increment_pc,
				input alu_add_sub, alu_set_low, alu_set_high,
				input load_temp, increment_temp, decrement_temp,
				input [1:0] select_immediate,
				input [1:0] select_write_address,
				// Status outputs
				output br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause,
				output delay_done,
				output temp_is_positive, temp_is_negative, temp_is_zero,
				output register0_is_zero,
				// Motor control outputs
				output [3:0] stepper_signals
);
// The comment /*synthesis keep*/ after the declaration of a wire
// prevents Quartus from optimizing it, so that it can be observed in simulation
// It is important that the comment appear before the semicolon
wire [7:0] position /*synthesis keep*/;
wire [7:0] delay /*synthesis keep*/;
wire [7:0] register0 /*synthesis keep*/;

decoder the_decoder (
	// Inputs
	.instruction (),
	// Outputs
	.br (),
	.brz (),
	.addi (),
	.subi (),
	.sr0 (),
	.srh0 (),
	.clr (),
	.mov (),
	.mova (),
	.movr (),
	.movrhs (),
	.pause ()
);
regfile the_regfile(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.write (write_reg_file), // red line from diagram
	.data (RM_out), // 8 bit 
	.select0 (IM_Q[]), // need to add index // 2 bit
	.select1 (IM_Q[]), // need to add index // 2 bit
	.wr_select (WAS_out), // 2 bit
	// Outputs
	.selected0 (RF_selected0), // 8 bit
	.selected1 (RF_selected1), // 8 bit
	.delay (delay),
	.position (position),
	.register0 (register0)
);

op1_mux the_op1_mux(
	// Inputs
	.select (),
	.pc (),
	.register (),
	.register0 (register0),
	.position (position),
	// Outputs
	.result()
);

op2_mux the_op2_mux(
	// Inputs
	.select (),
	.register (),
	.immediate (),
	// Outputs
	.result ()
);

delay_counter the_delay_counter(
	// Inputs
	.clk(),
	.reset_n (),
	.start (),
	.enable (),
	.delay (delay),
	// Outputs
	.done ()
);

stepper_rom the_stepper_rom(
	// Inputs
	.address (),
	.clock (),
	// Outputs
	.q ()
);

wire [7:0] PC_out;
wire [7:0] ALU_out;

pc the_pc(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.branch (commit_branch),
	.increment (increment_pc),
	.newpc (ALU_out), //8 bit
	// Outputs
	.pc (PC_out) //8 bit
);

wire [7:0] IM_Q;

instruction_rom the_instruction_rom(
	// Inputs
	.address (PC_out),
	.clock (clk),
	// Outputs
	.q (IM_Q) // 8 bit
);

alu the_alu(
	// Inputs
	.add_sub (),
	.set_low (),
	.set_high (),
	.operanda (),
	.operandb (),
	// Outputs
	.result ()
);

temp_register the_temp_register(
	// Inputs
	.clk (),
	.reset_n (),
	.load (),
	.increment (),
	.decrement (),
	.data (),
	// Outputs
	.negative (),
	.positive (),
	.zero ()
);

immediate_extractor the_immediate_extractor(
	// Inputs
	.instruction (),
	.select (),
	// Outputs
	.immediate ()
);

write_address_select the_write_address_select(
	// Inputs
	.select (),
	.reg_field0 (),
	.reg_field1 (),
	// Outputs
	.write_address()
);

result_mux the_result_mux (
	.select_result (),
	.alu_result (),
	.result ()
);

branch_logic the_branch_logic(
	// Inputs
	.register0 (register0),
	// Outputs
	.branch ()
);

endmodule
