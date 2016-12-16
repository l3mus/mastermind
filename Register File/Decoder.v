// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 32-bit"
// VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
// CREATED		"Sat Nov 28 19:09:38 2015"

module Decoder(
	CLOCK,
	color_add,
	blue,
	green,
	red
);


input wire	CLOCK;
input wire	[2:0] color_add;
output wire	[9:0] blue;
output wire	[9:0] green;
output wire	[9:0] red;






rf_red	b2v_inst(
	.clock(CLOCK),
	.address(color_add),
	.q(red));


rf_green	b2v_inst1(
	.clock(CLOCK),
	.address(color_add),
	.q(green));


rf_blue	b2v_inst2(
	.clock(CLOCK),
	.address(color_add),
	.q(blue));


endmodule
