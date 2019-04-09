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
				output [3:0] stepper_signals,
//				testing
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
				output [7:0] RM_out /*synthesis keep*/
);
// The comment /*synthesis keep*/ after the declaration of a wire
// prevents Quartus from optimizing it, so that it can be observed in simulation
// It is important that the comment appear before the semicolon

//wire [7:0] RF_selected0 /*synthesis keep*/;
//wire [7:0] RF_selected1 /*synthesis keep*/;
//wire [7:0] RF_2out /*synthesis keep*/;
//wire [7:0] RF_0out /*synthesis keep*/;
//wire [7:0] RF_3out /*synthesis keep*/;
//wire [7:0] Op1mux_out /*synthesis keep*/;
//wire [7:0] Op2mux_out /*synthesis keep*/;
//wire [7:0] PC_out /*synthesis keep*/;
//wire [7:0] ALU_out /*synthesis keep*/;
//wire [7:0] IM_Q /*synthesis keep*/;
//wire [7:0] IE_out /*synthesis keep*/;
//wire [1:0] WAS_out /*synthesis keep*/;
//wire [7:0] RM_out /*synthesis keep*/;

decoder the_decoder (
	// Inputs
	.instruction (IM_Q[7:2]), // 6 bits
	// Outputs
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
	.pause (pause)
);



regfile the_regfile(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.write (write_reg_file), // red line from diagram
	.data (RM_out), // 8 bit 
	.select0 (IM_Q[1:0]), // 2 bit
	.select1 (IM_Q[3:2]), // 2 bit
	.wr_select (WAS_out), // 2 bit
	// Outputs
	.selected0 (RF_selected0), // 8 bit
	.selected1 (RF_selected1), // 8 bit
	.delay (RF_3out), // 8 bits
	.position (RF_2out), // 8 bits
	.register0 (RF_0out) // 8 bits
);


op1_mux the_op1_mux(
	// Inputs
	.select (op1_mux_select),
	.pc (PC_out),
	.register (RF_selected0),
	.register0 (RF_2out),
	.position (RF_0out),
	// Outputs
	.result(Op1mux_out) // 8 bits
);


op2_mux the_op2_mux(
	// Inputs
	.select (op2_mux_select),
	.register (RF_selected1),
	.immediate (IE_out),
	// Outputs
	.result (Op2mux_out) // 8 bits
);

delay_counter the_delay_counter(
	// Inputs
	.clk(clk),
	.reset_n (reset_n),
	.start (start_delay_counter),
	.enable (enable_delay_counter),
	.delay (RF_0out),
	// Outputs
	.done (delay_done)
);

stepper_rom the_stepper_rom(
	// Inputs
	.address (RF_2out[2:0]), //need to add index // 3 bits
	.clock (clk),
	// Outputs
	.q (stepper_signals)
);



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



instruction_rom the_instruction_rom(
	// Inputs
	.address (PC_out),
	.clock (clk),
	// Outputs
	.q (IM_Q) // 8 bit
);

alu the_alu(
	// Inputs
	.add_sub (alu_add_sub),
	.set_low (alu_set_low),
	.set_high (alu_set_high),
	.operanda (Op1mux_out),
	.operandb (Op2mux_out),
	// Outputs
	.result (ALU_out) // 8 bit
);

temp_register the_temp_register(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.load (load_temp),
	.increment (increment_temp),
	.decrement (decrement_temp),
	.data (RF_selected0),
	// Outputs
	.negative (temp_is_negative),
	.positive (temp_is_positive),
	.zero (temp_is_zero)
);


immediate_extractor the_immediate_extractor(
	// Inputs
	.instruction (IM_Q[4:0]), // need to add index // 5 bits
	.select (select_immediate),
	// Outputs
	.immediate (IE_out) // 8 bits
);


write_address_select the_write_address_select(
	// Inputs
	.select (select_write_address),
	.reg_field0 (IM_Q[1:0]), // need to add index // 2 bits
	.reg_field1 (IM_Q[3:2]), // need to add index // 2 bits
	// Outputs
	.write_address(WAS_out) // 2 bits
);


result_mux the_result_mux (
	.select_result (result_mux_select),
	.alu_result (ALU_out),
	.result (RM_out) // 8 bits
);


branch_logic the_branch_logic(
	// Inputs
	.register0 (RF_0out),
	// Outputs
	.branch (register0_is_zero)
);

endmodule
