module textbox(
	input iCLK1,iCLK2,
	input [9:0] px,
	input [9:0] py,
	output reg [9:0] oR,
	output reg [9:0] oG,
	output reg [9:0] oB,
	output reg valid,
	output pixel
);
parameter COLS = 64;
parameter ROWS = 16;

// test that we are inside the textbox
always
	if (px>=COLS*8) valid <= 1'b0;
	else if (py>=ROWS*16) valid <= 1'b0;
	else begin
		oR <= 10'h3FF;
		oG <= 10'h3FF;
		oB <= 10'h3FF;
		valid <= 1'b1;
	end
// instantiate text memory
chars mem1(
	.address(character_address),
	.clock(~iCLK1), 
	.wren(1'b0),
	.q(qchr)
	);

// calculate character address
wire [9:0] character_address = {py[7:4],px[8:3]};
wire [7:0] qchr;

// instantiate sysfont memory
sysfont mem2(
	.address(address),
	.clock(iCLK2),
	.q(q)
	);
wire [10:0] address = {	qchr[6:0], py[3:0] };
wire [7:0] q;
reg rom_mux_output;

	// Mux to pick off correct rom data bit from 8-bit word
	// for on screen character generation
	always
	case (px[2:0])
	0: rom_mux_output = q[0];
	1: rom_mux_output = q[7];
	2: rom_mux_output = q[6];
	3: rom_mux_output = q[5];
	4: rom_mux_output = q[4];
	5: rom_mux_output = q[3];
	6: rom_mux_output = q[2];
	7: rom_mux_output = q[1];
	endcase
	
	assign pixel = rom_mux_output;
	
endmodule



	