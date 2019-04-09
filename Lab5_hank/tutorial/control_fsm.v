module control_fsm (
	input clk, reset_n,
	// Status inputs
	input br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause,
	input delay_done,
	input temp_is_positive, temp_is_negative, temp_is_zero,
	input register0_is_zero,
	// Control signal outputs
	output reg write_reg_file,
	output reg result_mux_select,
	output reg [1:0] op1_mux_select, op2_mux_select,
	output reg start_delay_counter, enable_delay_counter,
	output reg commit_branch, increment_pc,
	output reg alu_add_sub, alu_set_low, alu_set_high,
	output reg load_temp_register, increment_temp_register, decrement_temp_register,
	output reg [1:0] select_immediate,
	output reg [1:0] select_write_address
	
);
parameter RESET			=5'b00000,	// resets values
			 FETCH			=5'b00001,	// incremenpts PC and loads instructions
			 DECODE			=5'b00010,	// sets which command
			 BR				=5'b00011,	// operation for BR
			 BRZ				=5'b00100,	// operation for BRZ
			 ADDI				=5'b00101,	// operation for ADDI
			 SUBI				=5'b00110,	// operation for SUBI
			 SR0				=5'b00111,	// operation for SR0
			 SRH0				=5'b01000,	// operation for SRH0
			 CLR				=5'b01001,	// operation for CLR
			 MOV				=5'b01010,	// operation for MOV
			 MOVA				=5'b01011,	// operation for MOVA
			 MOVR				=5'b01100,	// operation for MOVR
			 MOVR_STAGE2	=5'b01111,
			 MOVR_DELAY		=5'b10000,
			 MOVRHS			=5'b01101,	// operation for MOVRHS
			 MOVRHS_STAGE2	=5'b10001,
			 MOVRHS_DELAY	=5'b10010,
			 PAUSE			=5'b01110,	// operation for PAUSE
			 PAUSE_DELAY	=5'b10011;

reg [4:0] state;

// Next state logic
always @(posedge clk)
begin
	if(reset_n == 1'b0) state = RESET;
	else
	begin
		case(state)
			RESET:			state = DECODE;
			FETCH:			state = DECODE;
			DECODE: begin
				if(br)				state = BR;
				else if(brz)		state = BRZ;
				else if(addi)		state = ADDI;
				else if(subi)		state = SUBI;
				else if(sr0)		state = SR0;
				else if(srh0)		state = SRH0;
				else if(clr)		state = CLR;
				else if(mov)		state = MOV;
				else if(mova)		state = MOVA;
				else if(movr)		state = MOVR;
				else if(movrhs)	state = MOVRHS;
				else if(pause)		state = PAUSE;
			end
				
			BR:				state = DECODE;
			BRZ:				state = DECODE;
			ADDI:				state = FETCH;
			SUBI:				state = FETCH;
			SR0:				state = FETCH;
			SRH0:				state = FETCH;
			CLR:				state = FETCH;
			MOV:				state = FETCH;
			MOVA:				state = FETCH;
			
			MOVR:				state = MOVR_DELAY;
			MOVR_DELAY: 	if (temp_is_zero == 1'b1) state = MOVR_STAGE2;
			MOVR_STAGE2:	state = FETCH;
			
			MOVRHS:			state = MOVRHS_DELAY;
			MOVRHS_DELAY:	if (temp_is_zero == 1'b1) state = MOVRHS_STAGE2;
			MOVRHS_STAGE2:	state = FETCH;
			
			PAUSE:			state = PAUSE_DELAY;
			PAUSE_DELAY:	if(delay_done == 1'b1) state = FETCH;
			
			default:			state = RESET;
		endcase
	end
end

// State register


// Output logic
always @(posedge clk)
begin
	write_reg_file				= 1'b0;
	result_mux_select			= 1'b0;
	op1_mux_select				= 2'b0;
	op2_mux_select				= 2'b0;
	start_delay_counter		= 1'b0;
	enable_delay_counter		= 1'b0;
	commit_branch				= 1'b0;
	increment_pc				= 1'b0;
	alu_add_sub					= 1'b0;
	alu_set_low					= 1'b0;
	alu_set_high				= 1'b0;
	load_temp_register		= 1'b0;
	increment_temp_register	= 1'b0;
	decrement_temp_register	= 1'b0;
	select_immediate			= 2'b0;
	select_write_address		= 2'b0;
	case(state)
		RESET: begin
			write_reg_file				= 1'b0;
			result_mux_select			= 1'b0;
			op1_mux_select				= 2'b0;
			op2_mux_select				= 2'b0;
			start_delay_counter		= 1'b0;
			enable_delay_counter		= 1'b0;
			commit_branch				= 1'b0;
			increment_pc				= 1'b0;
			alu_add_sub					= 1'b0;
			alu_set_low					= 1'b0;
			alu_set_high				= 1'b0;
			load_temp_register		= 1'b0;
			increment_temp_register	= 1'b0;
			decrement_temp_register	= 1'b0;
			select_immediate			= 2'b0;
			select_write_address		= 2'b0;
		end
		FETCH: begin
//			write_reg_file				= 1'b0;
//			start_delay_counter		= 1'b0;
//			enable_delay_counter		= 1'b0;
//			commit_branch				= 1'b0;
//			increment_pc				= 1'b1;
//			alu_add_sub					= 1'b0;
//			alu_set_low					= 1'b0;
//			alu_set_high				= 1'b0;
//			load_temp_register		= 1'b0;
//			increment_temp_register	= 1'b0;
//			decrement_temp_register	= 1'b0;
		end
		DECODE: begin
			write_reg_file				= 1'b0;
			start_delay_counter		= 1'b0;
			enable_delay_counter		= 1'b0;
			commit_branch				= 1'b0;
			increment_pc				= 1'b1;
			alu_add_sub					= 1'b0;
			alu_set_low					= 1'b0;
			alu_set_high				= 1'b0;
			load_temp_register		= 1'b0;
			increment_temp_register	= 1'b0;
			decrement_temp_register	= 1'b0;
		end
		BR: begin
			select_immediate	= 2'b10;
			op1_mux_select		= 2'b0;
			op2_mux_select		= 2'b1;
			alu_add_sub			= 1'b1;
			commit_branch		= 1'b1;
		end
		BRZ: begin
			if(register0_is_zero == 1'b1)
			begin
				select_immediate	= 2'b10;
				op1_mux_select		= 2'b0;
				op2_mux_select		= 2'b1;
				alu_add_sub			= 1'b1;
				commit_branch		= 1'b1;
			end
			else increment_pc		= 1'b1;
		end
		ADDI: begin
			select_immediate		= 2'b0;
			op1_mux_select			= 2'b1;
			op2_mux_select			= 2'b1;
			alu_add_sub				= 1'b1;
			result_mux_select		= 1'b0;
			select_write_address	= 2'b1;
			write_reg_file			= 1'b1;
		end
		SUBI: begin
			select_immediate		= 2'b0;
			op1_mux_select			= 2'b1;
			op2_mux_select			= 2'b1;
			alu_add_sub				= 1'b0;
			result_mux_select		= 1'b0;
			select_write_address	= 2'b1;
			write_reg_file			= 1'b1;
		end
		SR0: begin
			select_immediate		= 2'b1;
			op1_mux_select			= 2'b11;
			op2_mux_select			= 2'b1;
			alu_set_low				= 1'b1;
			result_mux_select		= 1'b0;
			select_write_address	= 1'b0;
			write_reg_file 		= 1'b1;
		end
		SRH0: begin
			select_immediate		= 2'b1;
			op1_mux_select			= 2'b11;
			op2_mux_select			= 2'b1;
			alu_set_high			= 1'b1;
			result_mux_select		= 1'b0;
			select_write_address	= 1'b0;
			write_reg_file 		= 1'b1;
		end
		CLR: begin
			result_mux_select		= 1'b1;
			select_write_address = 2'b1;
			write_reg_file			= 1'b1;
		end
		MOV: begin
			select_immediate		= 2'b11;
			op1_mux_select			= 2'b1;
			op2_mux_select			= 2'b1;
			result_mux_select		= 1'b0;
			select_write_address	= 2'b10;
			write_reg_file 		= 1'b1;
		end
		MOVA: begin
		
		end
		MOVR:				load_temp_register = 1'b1;
		MOVR_DELAY: begin
			op1_mux_select				= 2'b1;
			op2_mux_select				= 2'b11;
			result_mux_select			= 1'b0;
			select_write_address 	= 1'b1;
			write_reg_file				= 1'b1;
			
			if (temp_is_positive == 1'b1)
			begin
				decrement_temp_register	= 1'b1;
				alu_add_sub					= 1'b0;
			end else if (temp_is_negative == 1'b1)
			begin
				increment_temp_register	= 1'b1;
				alu_add_sub					= 1'b1;
			end
		end
		MOVR_STAGE2:
		
		MOVRHS:			load_temp_register = 1'b1;
		MOVRHS_DELAY: begin
			op1_mux_select				= 2'b1;
			op2_mux_select				= 2'b10;
			result_mux_select			= 1'b0;
			select_write_address 	= 1'b1;
			write_reg_file				= 1'b1;
			
			if (temp_is_positive == 1'b1)
			begin
				decrement_temp_register	= 1'b1;
				alu_add_sub					= 1'b0;
			end else if (temp_is_negative == 1'b1)
			begin
				increment_temp_register	= 1'b1;
				alu_add_sub					= 1'b1;
			end
		end
		MOVRHS_STAGE2:
		
		PAUSE:			start_delay_counter = 1'b1;
		PAUSE_DELAY:   if(delay_done == 1'b0) enable_delay_counter = 1'b1;
	endcase
end
endmodule
