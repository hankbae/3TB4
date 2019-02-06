module reaction_game(
	input        CLOCK_50,
	input	 [3:0] KEY,
	output [6:0] HEX0,
					 HEX1,
					 HEX2,
					 HEX3,
					 HEX4,
					 HEX5,
	output [9:0] LEDR,
	);
	
	reg rng_reset,rng_start, init_start,init_stop,stopwatch_start,stopwatch_stop;
	reg [2:0] P1_point, P2_point;
	reg [14:0] rng_delay;
	reg [23:0] HEX_val;
	
	wire clk, rng_ready;
	wire [14:0] rng_delayBuff;
	wire [19:0] divisor,init_timer stopwatch_timer, rng_timer;
	assign divisor = 20'b4;		// divisor for clock
	
	
	
	clock_divider msec(CLOCK_50,KEY[1],divisor,clk);
	
	// init_timer initialization 
	hex_counter init_delay(clk,KEY[1],init_start,init_stop,init_timer);
	
	
	// rng_timer initialization 
	random RNG(clk,rng_reset,rng_delay_buff,rng_ready);
	hex_counter random_delay(clk,KEY[1],rng_start,1'b1,rng_timer);
	
	
	// stopwatch_timer initialization 
	hex_counter stopwatch(clk,KEY[1],stopwatch_start,stopwatch_stop,stopwatch_timer);
	
	
	// HEX display
	num_decoder hex0(HEX_val[3:0],HEX0);
	num_decoder hex1(HEX_val[7:4],HEX0);
	num_decoder hex2(HEX_val[11:8],HEX0);
	num_decoder hex3(HEX_val[15:12],HEX0);
	num_decoder hex4(HEX_val[19:16],HEX0);
	num_decoder hex5(HEX_val[23:20],HEX0);
	
	// LED display
	led_decoder P1(P1_points,LEDR[4:0]);
	led_decoder P2(P2_points,LEDR[9:5]);
	
	
	always @(posedge CLOCK_50 or posedge rng_ready)
	begin
	
	
		// resets to inital conditions
		if (KEY[1] == 1'b0) rng_delay <= 15'b0;
		
		// reads random time value
		if ((rng_ready == 1'b1)&&(rng_delay == 15'b0)) rng_delay <= rng_delayBuff; // may have to change this to blocking
		
		
		// start of all the states
		init_start 			<= 1'b0; // init counter started
		init_stop 			<= 1'b1;	// HEX flashing, LEDR off
		rng_start 			<= 1'b1;
		rng_reset 			<= 1'b0;
		stopwatch_start 	<= 1'b1;
		stopwatch_stop 	<= 1'b0;
		
		if (init_timer >= 20'd2000)
		begin
			init_start 			<= 1'b1;	// rng counter started, init counter off
			init_stop 			<= 1'b0;	// HEX off, LEDR off
			rng_start 			<= 1'b0;
			rng_reset 			<= 1'b1;
			stopwatch_start 	<= 1'b1;
			stopwatch_stop 	<= 1'b0;
			
			if ((rng_delay != 15'b0)&&(rng_timer >= rng_delay))
			begin
				init_start 			<= 1'b1;	// stopwatch started,rng counter off
				init_stop 			<= 1'b0;	// HEX displays time in msec
				rng_start 			<= 1'b1;	// LEDR off
				rng_reset 			<= 1'b0;
				stopwatch_start 	<= 1'b0;
				stopwatch_stop 	<= 1'b1;
				
				
				if (KEY[0]==1'b0)
				begin
					init_start 			<= 1'b1;
					init_stop 			<= 1'b0;
					rng_start 			<= 1'b1;
					rng_reset 			<= 1'b0;
					stopwatch_start 	<= 1'b1;
					stopwatch_stop 	<= 1'b0;
					
					P1_point <= P1_point + 3'b1; 	// increments point displays time on HEX
															// and displays points in ledr
					if (KEY[2]==1'b0)
					begin
						rng_delay 	<= 15'b0;		// resetting to inital state
						init_timer 	<= 20'b0;
						rng_timer 	<= 15'b0;
					end 
				end else if (KEY[3]== 1'b0)
				begin
					init_start 			<= 1'b1;
					init_stop 			<= 1'b0;
					rng_start 			<= 1'b1;
					rng_reset 			<= 1'b0;
					stopwatch_start 	<= 1'b1;
					stopwatch_stop 	<= 1'b0;
					
					P1_point <= P1_point + 3'b1; 	// increments point displays time on HEX
															// and displays points in ledr
					if (KEY[2]==1'b0)
					begin
						rng_delay 	<= 15'b0;				// resetting to inital state
						init_timer 	<= 20'b0;
						rng_timer 	<= 15'b0;
					end 
				end
				
			end
			
			if (KEY[0]==1'b0)
			begin								// P1 cheating
				HEX_val 		<= 24'd1;	// timer stops
				rng_start 	<= 1'b1;		// hex displays 1
				rng_reset 	<= 1'b0;	
			
			end
			if (KEY[3]==1'b0)
			begin								// P2 cheating
				HEX_val 		<= 24'd2;	// timer stops
				rng_start 	<= 1'b1;		// hex displays 2
				rng_reset 	<= 1'b0;	
			
			end
			
			
			
			
		end
		
	end
	
	
	
	
endmodule
