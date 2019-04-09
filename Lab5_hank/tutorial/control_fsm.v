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
parameter RESET=5'b00000, FETCH=5'b00001, DECODE=5'b00010,
			BR=5'b00011, BRZ=5'b00100, ADDI=5'b00101, SUBI=5'b00110, SR0=5'b00111,
			SRH0=5'b01000, CLR=5'b01001, MOV=5'b01010, MOVA=5'b01011,
			MOVR=5'b01100, MOVRHS=5'b01101, PAUSE=5'b01110, MOVR_STAGE2=5'b01111,
			MOVR_DELAY=5'b10000, MOVRHS_STAGE2=5'b10001, MOVRHS_DELAY=5'b10010,
			PAUSE_DELAY=5'b10011;

reg [4:0] state;
reg [4:0] next_state_logic; // NOT REALLY A REGISTER!!!

// Next state logic
	

// State register

always @(posedge clk)
begin
	if (reset_n == 1'b0)
	begin
		write_reg_file <= 1'b0;
		result_mux_select <= 1'b0;
		op1_mux_select <= 2'b00;
		op2_mux_select <= 2'b00;
		start_delay_counter <= 1'b0;
		enable_delay_counter <= 1'b0;
		commit_branch <= 1'b0;
		increment_pc <= 1'b0;
		alu_add_sub <= 1'b0;
		alu_set_low <= 1'b0;
		alu_set_high <= 1'b0;
		load_temp_register <= 1'b0;
		increment_temp_register <= 1'b0;
		decrement_temp_register <= 1'b0;
		select_immediate <= 2'b00;
		select_write_address <= 2'b00;
	end else
	begin
		write_reg_file <= 1'b0;
		result_mux_select <= 1'b0;
		op1_mux_select <= 2'b00;
		op2_mux_select <= 2'b00;
		start_delay_counter <= 1'b0;
		enable_delay_counter <= 1'b0;
		commit_branch <= 1'b0;
		increment_pc <= 1'b0;
		alu_add_sub <= 1'b0;
		alu_set_low <= 1'b0;
		alu_set_high <= 1'b0;
		load_temp_register <= 1'b0;
		increment_temp_register <= 1'b0;
		decrement_temp_register <= 1'b0;
		select_immediate <= 2'b00;
		select_write_address <= 2'b00;
		case(1'b1)
			br: begin
				select_immediate <= 2'b10;
				op1_mux_select <= 2'b0;
				op2_mux_select <= 2'b1;
				
				#1 alu_add_sub <= 1'b1;
				
				#2 commit_branch <= 1'b1;				
			end
			brz: begin
				if (register0_is_zero == 1'b1)
				begin
					select_immediate <= 2'b10;
					op1_mux_select <= 2'b0;
					op2_mux_select <= 2'b1;
					
					#1 alu_add_sub <= 1'b1;
					
					#2 commit_branch <= 1'b1;		
				end else
				begin
					select_immediate <= 2'b10;
					op1_mux_select <= 2'b0;
					op2_mux_select <= 2'b1;
					
					#1 alu_add_sub <= 1'b1;
					
					#2 commit_branch <= 1'b1;	
				end
			end
			addi: begin
				select_immediate <= 2'b0;
				
				op1_mux_select <= 2'b1;
				op2_mux_select <= 2'b1;
				result_mux_select <= 1'b0;
				select_write_address<= 2'b1;
				
				#1 alu_add_sub <= 1'b1;
				
				
				#2 write_reg_file <= 1'b1;
				
				#3 increment_pc <= 1'b1;
			end
			subi: begin
				alu_add_sub <= 1'b0;
				op1_mux_select <= 2'b1;
				op2_mux_select <= 2'b1;
				select_immediate <= 2'b0;
				write_reg_file <= 1'b1;
				select_write_address<= 2'b1;
				result_mux_select <= 1'b0;
				
				increment_pc <= 1'b1;
			end
			sr0: begin
				select_immediate <= 2'b1;
				alu_set_low <= 1'b1;
				op1_mux_select <= 2'b1;
				op2_mux_select <= 2'b1;
				write_reg_file <= 1'b1;
				result_mux_select <= 1'b0;
				select_write_address <= 2'b1;
				
				increment_pc <= 1'b1;
			end
			srh0: begin
				select_immediate <= 2'b1;
				alu_set_high <= 1'b1;
				op1_mux_select <= 2'b1;
				op2_mux_select <= 2'b1;
				write_reg_file <= 1'b1;
				result_mux_select <= 1'b0;
				select_write_address <= 2'b1;
				
				increment_pc <= 1'b1;
			end
			clr: begin
				select_write_address <= 2'b1;
				write_reg_file <= 1'b1;
				result_mux_select <= 1'b1;
				
				increment_pc <= 1'b1;
			end
			mov: begin
				select_write_address <= 2'b10;
				write_reg_file <= 1'b1;
				op1_mux_select <= 2'b1;
				op2_mux_select <= 2'b0;
				
				increment_pc <= 1'b1;
			end
			mova: begin
				select_immediate <= 2'b11;
				result_mux_select <= 1'b0;
				write_reg_file <= 1'b1;
				select_write_address <= 2'b10;
				op1_mux_select <= 2'b1;
				op2_mux_select <= 2'b1;
				
				increment_pc <= 1'b1;
			end
			movr: begin
				
				if (load_temp_register == 1'b0)
				begin
					load_temp_register <=1'b1;
				end else
				begin
					load_temp_register <= 1'b0;
					if (temp_is_positive == 1'b1)
					begin
						decrement_temp_register <= 1'b1;
						write_reg_file <= 1'b1;
						select_write_address <= 2'b11;
						op1_mux_select <= 2'b10;
						op2_mux_select <= 2'b11;
						alu_add_sub <= 1'b1;
						result_mux_select <= 1'b0;
					end else if (temp_is_negative == 1'b1)
					begin
						increment_temp_register <= 1'b1;
						write_reg_file <= 1'b1;
						select_write_address <= 2'b11;
						op1_mux_select <= 2'b10;
						op2_mux_select <= 2'b11;
						alu_add_sub <= 1'b0;
						result_mux_select <= 1'b0;					
					end else if (temp_is_zero == 1'b1)
					begin
						increment_pc <= 1'b1;
					end
				end
			end
			movrhs: begin
				load_temp_register <= 1'b0;
				if (load_temp_register == 1'b0)
				begin
					load_temp_register <=1'b1;
				end else
				begin
					load_temp_register <= 1'b0;
					if (temp_is_positive == 1'b1)
					begin
						decrement_temp_register <= 1'b1;
						write_reg_file <= 1'b1;
						select_write_address <= 2'b11;
						op1_mux_select <= 2'b10;
						op2_mux_select <= 2'b10;
						alu_add_sub <= 1'b1;
						result_mux_select <= 1'b0;
					end else if (temp_is_negative == 1'b1)
					begin
						increment_temp_register <= 1'b1;
						write_reg_file <= 1'b1;
						select_write_address <= 2'b11;
						op1_mux_select <= 2'b10;
						op2_mux_select <= 2'b10;
						alu_add_sub <= 1'b0;
						result_mux_select <= 1'b0;					
					end else if (temp_is_zero == 1'b1)
					begin
						increment_pc <= 1'b1;
					end
				end			
			end
			pause: begin
				start_delay_counter <= 1'b0;
				if (start_delay_counter == 1'b0)
				begin
					start_delay_counter <= 1'b1;
				end else
				begin
					start_delay_counter <= 1'b0;
					enable_delay_counter <= 1'b1;
					if (delay_done == 1'b1)
					begin
						increment_pc <=1'b1;
					end
				end
			end
		endcase
	end
end


// Output logic


endmodule
