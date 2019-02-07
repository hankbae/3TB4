module reaction_game(
	input        CLOCK_50,
	input	 [3:0] KEY,
	output [6:0] HEX0,
					 HEX1,
					 HEX2,
					 HEX3,
					 HEX4,
					 HEX5,
	output [9:0] LEDR
	);
	
	reg 			 rng_start;
	reg			 init_start;
	reg			 init_stop;
	reg			 stopwatch_start;
	reg			 stopwatch_stop;
	reg			 HEX_flashing;
	reg			 HEX_off;
	reg			 P1_ledEnable;
	reg			 P2_ledEnable;
	reg			 P1_addPoint;
	reg			 P2_addPoint;
	reg			 P1_press;
	reg			 P2_press;
	reg			 main_reset;
	reg 	[14:0] rng_delay;
	reg 	[23:0] HEX_val;
	
	
	wire 			 clk;
	wire 			 rng_ready;
	wire  	[2:0]	 P1_points, P2_points;
	wire  	[14:0] rng_delayBuff;
	wire  	[19:0] divisor, init_timer, stopwatch_timer, rng_timer;
	wire  	[23:0] HEX_buff;
	
	
	assign divisor = 20'd50000;		// divisor for clock (original: 20'd50000)
	
	
	
	clock_divider 	msec			 (CLOCK_50,1'b1,divisor,clk);
	
	// init_timer initialization
	hex_counter 	init_delay	 (clk,main_reset,init_start,init_stop,init_timer);
	
	
	// rng_timer initialization
	random			RNG(CLOCK_50,1'b1,rng_delayBuff,rng_ready);
	hex_counter 	random_delay (clk,main_reset,rng_start,~rng_start,rng_timer);
	
	
	// stopwatch_timer initialization
	hex_counter 	stopwatch	 (clk,main_reset,stopwatch_start,stopwatch_stop,stopwatch_timer);
	
	
	// HEX display
	bin2BCD			hexTimer		 (stopwatch_timer,HEX_buff);
	
	num_decoder 	hex0			 (clk,HEX_flashing,HEX_off,HEX_val[3:0],HEX0);
	num_decoder 	hex1			 (clk,HEX_flashing,HEX_off,HEX_val[7:4],HEX1);
	num_decoder 	hex2			 (clk,HEX_flashing,HEX_off,HEX_val[11:8],HEX2);
	num_decoder 	hex3			 (clk,HEX_flashing,HEX_off,HEX_val[15:12],HEX3);
	num_decoder 	hex4			 (clk,HEX_flashing,HEX_off,HEX_val[19:16],HEX4);
	num_decoder 	hex5			 (clk,HEX_flashing,HEX_off,HEX_val[23:20],HEX5);
	
	// LED display
	led_decoder 	P1_led		 (P1_points,P1_ledEnable,LEDR[4:0]);
	led_decoder 	P2_led		 (P2_points,P2_ledEnable,LEDR[9:5]);
	
	// Player point addition
	
	add_point 		P1				 (P1_addPoint,P1_points);
	add_point 		P2				 (P2_addPoint,P2_points);
	
	initial	// initial conditions
	begin
		P1_press		 <= 1'b0;
		P2_press		 <= 1'b0;
		P1_ledEnable <= 1'b0;		// LEDR off
		P2_ledEnable <= 1'b0;
		main_reset	 <= 1'b1;
	end
	
	
	always @(posedge CLOCK_50)
	begin
		
		
		
		// resets to inital conditions
		if ((KEY[1]==1'b1)&&(KEY[2]==1'b1))
		begin
			
			// reads random time value
			if ((rng_ready == 1'b1)&&(rng_delay == 15'b0)) rng_delay <= rng_delayBuff;
			
			main_reset 		 <= 1'b1;
			
			// start of all the states
			init_start 		 <= 1'b0; 		// init counter started
			init_stop 		 <= 1'b1;	
			rng_start 		 <= 1'b1;
			stopwatch_start <= 1'b1;
			stopwatch_stop	 <= 1'b0;
			
			HEX_val 			 <= HEX_buff;
			HEX_flashing 	 <= 1'b1;		// HEX flashing, LEDR off
			HEX_off 			 <= 1'b0;
			P1_addPoint		 <= 1'b0;
			P2_addPoint		 <= 1'b0;

			
			if (init_timer >= 20'd2000) // originally 20'd2000
			begin
				
				init_start 		 <= 1'b1;		// rng counter started, init counter off
				init_stop 		 <= 1'b0;	
				rng_start 		 <= 1'b0;
				stopwatch_start <= 1'b1;
				stopwatch_stop	 <= 1'b0;
				
				HEX_val			 <= HEX_buff;
				HEX_flashing	 <= 1'b0;		// HEX off, LEDR off
				HEX_off			 <= 1'b1;
				P1_addPoint		 <= 1'b0;
				P2_addPoint		 <= 1'b0;
				
				if ((KEY[0] == 1'b0) && (P2_press == 1'b0))		 P1_press = 1'b1;
				else if ((KEY[3] == 1'b0) && (P1_press == 1'b0)) P2_press = 1'b1;
				
				if ((rng_timer >= rng_delay)&&(rng_delay != 15'b0))
				begin
					init_start		 <= 1'b1;		// stopwatch started,rng counter off
					init_stop		 <= 1'b0;
					rng_start		 <= 1'b1;	
					stopwatch_start <= 1'b0;
					stopwatch_stop	 <= 1'b1;
					
					HEX_val			 <= HEX_buff;
					HEX_flashing	 <= 1'b0;		// HEX displays time in msec
					HEX_off			 <= 1'b0;
					
					if ((KEY[0] == 1'b0) && (P2_press == 1'b0))		 P1_press = 1'b1;
					else if ((KEY[3] == 1'b0) && (P1_press == 1'b0)) P2_press = 1'b1;
					
					
					if (P1_press==1'b1)
					begin
						init_start		 <= 1'b1;
						init_stop		 <= 1'b0;
						rng_start		 <= 1'b1;
						stopwatch_start <= 1'b1;
						stopwatch_stop	 <= 1'b0;
						
						HEX_val			 <= HEX_buff;
						HEX_flashing	 <= 1'b0;			// displays reaction time on HEX
						HEX_off			 <= 1'b0;		
						P1_ledEnable	 <= 1'b1;			// and displays P1 points in ledr
						P2_ledEnable	 <= 1'b0;
						P1_addPoint		 <= 1'b1;
						P2_addPoint		 <= 1'b0;

						
						if (KEY[2]==1'b0) 
						begin		
							
							P1_press		 = 1'b0;
							P2_press		 = 1'b0;
							
							rng_delay	<= 15'b0;
							P1_addPoint	<= 1'b0;
							P2_addPoint	<= 1'b0;
							
						end
						
					end else if (P2_press==1'b1)
					begin
						init_start		 <= 1'b1;
						init_stop		 <= 1'b0;
						rng_start		 <= 1'b1;

						stopwatch_start <= 1'b1;
						stopwatch_stop	 <= 1'b0;
						
						HEX_val 			 <= HEX_buff;
						HEX_flashing 	 <= 1'b0;			// displays reaction time on HEX
						HEX_off 			 <= 1'b0;		
						P1_ledEnable 	 <= 1'b0;			// and displays P2 points in ledr
						P2_ledEnable 	 <= 1'b1;
						P1_addPoint		 <= 1'b0;
						P2_addPoint		 <= 1'b1;
						
						
						if (KEY[2]==1'b0) 
						begin
						
							P1_press		 = 1'b0;
							P2_press		 = 1'b0;
							
							rng_delay	<= 15'b0;			// resetting to inital state
							P1_addPoint	<= 1'b0;
							P2_addPoint	<= 1'b0;
							
						end
						
					end
					
				end
				
				if (P1_press == 1'b1)
				begin
					rng_start	 <= 1'b1;		// timer stops		
					
					HEX_val		 <= 24'b1;		// hex displays 1
					HEX_flashing <= 1'b0;		// P1 cheating
					HEX_off		 <= 1'b0;		
				end
				if (P2_press == 1'b1)
				begin
					rng_start	 <= 1'b1;		// timer stops	
					
					HEX_val		 <= 24'b10;		// hex displays 2
					HEX_flashing <= 1'b0;		// P2 cheating
					HEX_off		 <= 1'b0;		
				end
				
			end
		
		end else
		begin
			P1_press		  = 1'b0;
			P2_press		  = 1'b0;
			P1_addPoint	 <= 1'b0;
			P2_addPoint	 <= 1'b0;
			rng_delay	 <= 15'b0;
			P1_ledEnable <= 1'b0;		// LEDR off
			P2_ledEnable <= 1'b0;
			main_reset	 <= 1'b0;		// resetting to inital state
			
		end
		
	end
	
endmodule
