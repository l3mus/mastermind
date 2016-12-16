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

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
// CREATED		"Tue Dec 01 22:19:15 2015"

module register_file(
	WRITE_CHECK,
	WRITE_TRY,
	CLOCK,
	CHECK_ADD,
	CHECK_RGB,
	TRIES_RANDS_ADD,
	TRIES_RANDS_RGB,
	CHECK_RGB_ADD,
	TRIES_RANDS_RGB_ADD
);


input wire	WRITE_CHECK;
input wire	WRITE_TRY;
input wire	CLOCK;
input wire	[5:0] CHECK_ADD;
input wire	[2:0] CHECK_RGB;
input wire	[5:0] TRIES_RANDS_ADD;
input wire	[2:0] TRIES_RANDS_RGB;
output wire	[2:0] CHECK_RGB_ADD;
output wire	[2:0] TRIES_RANDS_RGB_ADD;






tries_randoms	b2v_inst(
	.wren(WRITE_TRY),
	.clock(CLOCK),
	.address(TRIES_RANDS_ADD),
	.data(TRIES_RANDS_RGB),
	.q(TRIES_RANDS_RGB_ADD));


check	b2v_inst1(
	.wren(WRITE_CHECK),
	.clock(CLOCK),
	.address(CHECK_ADD),
	.data(CHECK_RGB),
	.q(CHECK_RGB_ADD));


endmodule
