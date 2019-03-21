/*****************************************************************************
 *                                                                           *
 * Module:       Lab4                                                       *
 * Description:                                                              *
 *      This module is the top level module of MT3TB4 Lab 4                    *
 *                                                                           *
 *****************************************************************************/

module lab4 (
input				CLOCK_50,	
input		[0:0]	KEY, 
input 	[7:0] SW,               //for reset
output 	[7:0] LEDR,

// Bidirectionals
inout		[15:0]		DRAM_DQ,

// Outputs

output		[12:0]	DRAM_ADDR,
output 		[1:0]		DRAM_BA,
output					DRAM_LDQM,  //data mask; when it is low, the DQ is valid for reading and writing. 
output					DRAM_UDQM,
output					DRAM_RAS_N,
output 					DRAM_CAS_N,
output 					DRAM_CLK,
output					DRAM_CKE,
output 					DRAM_WE_N,
output 					DRAM_CS_N


);


// Internal Wires



assign LEDR=SW;

//Instantiate your sopc_system module generated by Platform Designer.  


sopc_system  controller (
		// example ports 
		.clk_clk(CLOCK_50),              //           clk.clk
		.reset_reset_n(KEY[0]),         //         reset.reset_n
		.sdram_clk_clk(DRAM_CLK),
		// more ports
		.Sdram_addr_export(DRAM_ADDR),
		.Sdram_ba_export(DRAM_BA),
		.Sdram_cas_n_export(DRAM_CAS_N),
		.Sdram_cke_export(DRAM_CKE),
		.Sdram_cs_n_export(DRAM_CS_N),
		.Sdram_dq_export(DRAM_DQ),
		.Sdram_ldqm_export(DRAM_LDQM),
		.Sdram_ras_n_export(DRAM_RAS_N),
		.Sdram_udqm_export(DRAM_UDQM),
		.Sdram_we_n_export(DRAM_WE_N)
	);
	
endmodule