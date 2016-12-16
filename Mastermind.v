// --------------------------------------------------------------------
// Copyright (c) 2005 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	VGA experments
// modifed by BRL4 for SRAM; Displays a color grid 
// VGA controller, PLL, and reset are from DE2 distribution CD
// --------------------------------------------------------------------

module Mastermind
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
	);
////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_27;				//	27 MHz
input			CLOCK_50;				//	50 MHz
////////////////////////	Push Button		////////////////////////
input	[3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	[17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////////	LED		////////////////////////////
output	[7:0]	LEDG;					//	LED Green[8:0]
output	[17:0]	LEDR;					//	LED Red[17:0]
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]

wire [9:0]	mVGA_R;
wire [9:0]	mVGA_G;
wire [9:0]	mVGA_B;
wire [19:0]	mVGA_ADDR;			//video memory address
wire [9:0]  Coord_X, Coord_Y;	//display coods
wire		DLY_RST;


Reset_Delay			r0	(	.iCLK(CLOCK_50),.oRESET(DLY_RST)	);

VGA_Audio_PLL 		p1	(	.areset(~DLY_RST),.inclk0(CLOCK_27),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);


VGA_Controller		u1	(	//	Host Side
							.iCursor_RGB_EN(4'b0111),
							.oAddress(mVGA_ADDR),
							.oCoord_X(Coord_X),
							.oCoord_Y(Coord_Y),
							.iRed(mVGA_R),
							.iGreen(mVGA_G),
							.iBlue(mVGA_B),
							//	VGA Side
							.oVGA_R(VGA_R),
							.oVGA_G(VGA_G),
							.oVGA_B(VGA_B),
							.oVGA_H_SYNC(VGA_HS),
							.oVGA_V_SYNC(VGA_VS),
							.oVGA_SYNC(VGA_SYNC),
							.oVGA_BLANK(VGA_BLANK),
							//	Control Signal
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST)	);

		
/////////////////  State Machine //////////////////////
reg [4:0] state;	
reg [5:0] sram_counter;
reg count_enable;
reg [5:0]i; 
reg screen;
reg [2:0] color_counter1;
reg [2:0] color_counter2;
reg [2:0] color_counter3;
reg [2:0] color_counter4;
reg [3:0] count_tries;
reg [3:0] multiplier;
reg [2:0] cc;
reg [2:0] ccp;
reg [2:0] check_cc_num;
/////////////// Register file ///////////////////////
reg write_check;
reg write_try;
reg [5:0] check_address;
reg [3:0] check_rgb;
reg [5:0] tries_rands_address;
reg [5:0] tries_rands_rgb;

//////////////// random generated colords ////////////////
reg [2:0] rand_color1;
reg [2:0] rand_color2;
reg [2:0] rand_color3;
reg [2:0] rand_color4;

reg [7:0] LEDG;
reg [17:0] LEDR;
wire reset;
wire start;
wire toggle;
wire ledG;
wire ledR;
wire toggle_box1;
wire toggle_box2;
wire toggle_box3;
wire toggle_box4;
wire color1;
wire color2;
wire color3;
wire counter;

assign reset = ~KEY[0];
assign start = ~KEY[1];
assign toggle = ~KEY[2];
assign set = ~KEY[3];
assign toggle_box1 = SW[17];
assign toggle_box2 = SW[16];
assign toggle_box3 = SW[15];
assign toggle_box4 = SW[14];


assign color1 = SW[0];
assign color2 = SW[1];
assign color3 = SW[2];

parameter clear = 4'd0, init = 4'd1, tries = 4'd2, compare = 4'd3, check_count = 4'd4, check_ccp = 4'd5, check_cc = 4'd6, ends = 4'd7, win = 4'd8, lose = 4'd9; 

always @ (posedge VGA_CTRL_CLK)
begin
	if (reset)		//synch reset assumes KEY0 is held down 1/60 second
	begin
			count_tries <= 0;
			count_enable <= 1'b1;
			sram_counter <= 0;
			count_tries <= 0;
			multiplier <= 4;
			state <= clear;
			//count_tries <= 0;
			//multiplier <= 4;
			//state <= init;	//first state in regular state machine 
	end 
	else
	begin
		case (state)
			clear:
			begin
				count_enable <= 1'b1;
				screen <= 0;
				if(sram_counter !=  6'b111111) begin
						tries_rands_address = tries_rands_address + sram_counter;
						check_address = tries_rands_address + sram_counter;
						write_try = 1'b1;
						write_check = 1'b1;
						tries_rands_rgb = 3'b000;
						check_rgb = 3'b000;
						sram_counter = sram_counter + 1;
						state <= clear;
					end
				else begin
					i <= 0;
					state <= init;
				end
			end
			init:
			begin	
				
			   LEDG <= 8'b00000000;
			   LEDR <= 17'b00000000000000000;
				screen <= 0;
				multiplier <= 4;
				if(start)begin
					count_enable <= 1'b0;
					state <= tries;
				end else	begin
					state <= init;
				end
			end
			tries:
			begin
			screen <= 1;
					if(~set) begin
						 if(toggle) begin
							if(toggle_box1 == 1'b1)begin
								write_check <= 1'b0;
								write_try <= 1'b1;	
								tries_rands_address <= count_tries * multiplier + 3;
								check_address <= 5'bxxxxx;
								check_rgb = 3'bxxx;
								tries_rands_rgb <=  {color3,color2,color1} ;
								color_counter1 <= {color3,color2,color1};
							end else	if(toggle_box2 == 1'b1)	begin
								write_check <= 1'b0;
								write_try <= 1'b1;	
								tries_rands_address <= count_tries * multiplier + 2;
								check_address <= 5'bxxxxx;
								check_rgb = 3'bxxx;
								tries_rands_rgb <=  {color3,color2,color1} ;
								color_counter2 <= {color3,color2,color1};
							end else	if(toggle_box3 == 1'b1)	begin
								write_check <= 1'b0;
								write_try <= 1'b1;	
								tries_rands_address <= count_tries * multiplier + 1;
								check_address <= 5'bxxxxx;
								check_rgb = 3'bxxx;
								tries_rands_rgb <=  {color3,color2,color1} ;
								color_counter3 <= {color3,color2,color1};
							end else	if(toggle_box4 == 1'b1) begin
								write_check <= 1'b0;
								write_try <= 1'b1;	
								tries_rands_address <= count_tries * multiplier;
								check_address <= 5'bxxxxx;
								check_rgb = 3'bxxx;
								tries_rands_rgb <=  {color3,color2,color1} ;
								color_counter4 <= {color3,color2,color1};
								end 
						end else  begin //end toggle
							write_check <= 1'b0;
							write_try <= 1'b0;	
							check_rgb <= 3'b000;
							tries_rands_rgb <= 3'b000;
							state <= tries;
						end
				   end else begin //end set
						i<=0;
						state<=compare;
						end
			end //End Tries State
			compare:
			begin
				if(~set) begin
					if(i != 4) begin
						if(i == 0) begin
								if(color_counter1 == rand_color1)begin
									ccp <= ccp + 1;
								end else if (color_counter1 == rand_color2 || color_counter1 == rand_color3 || color_counter1 == rand_color4)begin
									cc <= cc + 1;
								end
						end else if (i == 1)begin
								if(color_counter2 == rand_color2)begin
									ccp <= ccp + 1;
								end else if (color_counter2 == rand_color1 || color_counter2 == rand_color3 || color_counter2 == rand_color4)begin
									cc <= cc + 1;
								end
						end else if (i == 2) begin
								if(color_counter3 == rand_color3)begin
									ccp <= ccp + 1;
								end else if (color_counter3 == rand_color1 || color_counter3 == rand_color2 || color_counter3 == rand_color4)begin
									cc <= cc + 1;
								end
						end else if (i == 3)begin
								if(color_counter4 == rand_color4)begin
									ccp <= ccp + 1;
								end else if (color_counter4 == rand_color1 || color_counter4 == rand_color2 || color_counter4 == rand_color3)begin
									cc <= cc + 1;
								end
						end //end i == 3
						i <= i + 1; 
						state <= compare;
					end else begin //end i != 4
						i <= 0;
						check_cc_num <= cc;
						state <= check_count;
					end
				end //end set
			end //end compare
			check_count:
			begin
				if(i != check_cc_num)begin
					if(i == 0)begin
						if(color_counter1 == color_counter2 || color_counter1 == color_counter3 || color_counter1 == color_counter4)begin
							cc <= cc - 1;
							end
						end else if(i == 1)begin
							if(color_counter2 == color_counter3 || color_counter2 == color_counter4)begin
								cc <= cc - 1;
								end 
							end else if(i == 2)begin
								if(color_counter3 == color_counter4)begin
									cc <= cc - 1;
									end
								end //end i == 3
						i <= i + 1;
						state <= check_count;
				end else begin
					i <= 0;
					state <= check_ccp;
					end
			end		
			check_ccp:
			begin
				if(ccp != 4)begin
					if(i != ccp) begin 
						write_check <= 1'b1;
						write_try <= 1'b0;	
						tries_rands_address <= 5'bxxxxx ;
						check_address <= (count_tries * multiplier + 3) - i;
						check_rgb = 3'b100;
						tries_rands_rgb <=  3'bxxx;
						i <= i + 1; 
						state <= check_ccp;
					end else begin
						i <= 0;
						state <= check_cc;
					end
				end else begin
					state <= ends;
				end // ccp != 4
			end // check_ccp
			check_cc:
			begin
				if(i != cc)begin
					write_check <= 1'b1;
					write_try <= 1'b0;	
					tries_rands_address <= 5'bxxxxx ;
					check_address <= (count_tries * multiplier + 3 - ccp) - i;
					check_rgb = 3'b111;
					tries_rands_rgb <=  3'bxxx;
					i <= i + 1; 
					state <= check_cc;
				end else begin
					i <= 0;
					color_counter1 <= 0;
					color_counter2 <= 0;
					color_counter3 <= 0;
					color_counter4 <= 0;
					cc <= 0;
					ccp <= 0;
					check_cc_num <= 0;
					count_tries <= count_tries + 1;
					if(count_tries != 9)begin
					state <= tries;
					end else begin
					state <= ends;
					end
				end // i != cc
			end // end check_cc
			ends:
			begin
				if(i != 4) begin
					if(i == 0) begin
						write_check <= 1'b0;
						write_try <= 1'b1;	
						tries_rands_address <= 43;
						check_address <= 5'bxxxxx;
						check_rgb = 3'bxxx;
						tries_rands_rgb <=  rand_color1;
					end else if (i == 1)begin
						write_check <= 1'b0;
						write_try <= 1'b1;	
						tries_rands_address <= 42;
						check_address <= 5'bxxxxx;
						check_rgb = 3'bxxx;
						tries_rands_rgb <=  rand_color2;
					end else if (i == 2)begin
						write_check <= 1'b0;
						write_try <= 1'b1;	
						tries_rands_address <= 41;
						check_address <= 5'bxxxxx;
						check_rgb = 3'bxxx;
						tries_rands_rgb <=  rand_color3;
					end else if (i == 3) begin
						write_check <= 1'b0;
						write_try <= 1'b1;	
						tries_rands_address <= 40;
						check_address <= 5'bxxxxx;
						check_rgb = 3'bxxx;
						tries_rands_rgb <=  rand_color4;
					end 
					i <= i + 1; 
					state <= ends;
				end else begin
					if(ccp == 4)begin
					state <= win;
					end else begin
					state <= lose;
					end
				end
			end//display ends
			win:
			begin
			LEDG <= 8'b10101010;
			write_check <= 1'b0;
			write_try <= 1'b0;	
			check_rgb <= 3'b000;
			tries_rands_rgb <= 3'b000;
			state <= win;
			end
			lose:
			begin
			LEDR <= 17'b10101010101010101;
			write_check <= 1'b0;
			write_try <= 1'b0;	
			check_rgb <= 3'b000;
			tries_rands_rgb <= 3'b000;
			state <= lose;
			end
		endcase
	end
end
	
		
//assign	LEDR[8] =	18'h0;
//assign	LEDG[0] =	8'h0;

wire valid1, pixel1;
wire valid2, pixel2;
wire [9:0] red1;
wire [9:0] green1;
wire [9:0] blue1;
wire [9:0] red2;
wire [9:0] green2;
wire [9:0] blue2;
wire s1 = valid1 & pixel1;
wire s2 = valid2 & pixel2;

parameter WHITE = 10'h3FF;
parameter BLACK = 10'h000;

textbox u3(
	.iCLK1(VGA_CLK),
	.iCLK2(VGA_CTRL_CLK),
	.px(Coord_X),
	.py(Coord_Y),
	.oR(red2),
	.oG(green2),
	.oB(blue2),
	.valid(valid2),
	.pixel(pixel2)
);
wire [5:0] outCheck_address, outTries_address;

wire ct;
boxes u4(
	.iCLK1(VGA_CLK),
	.iCLK2(CLOCK_27),
	.px(Coord_X),
	.py(Coord_Y),
	.oCheck_Address(outCheck_address),
	.oTries_Address(outTries_address),
	.oCheck_or_Try(ct),
	.valid(valid1),
	.pixel(pixel1)
);

wire [5:0] check_address1, tries_address1;

assign check_address1 = write_check? check_address : outCheck_address;
assign tries_address1 = write_try? tries_rands_address : outTries_address;

wire [2:0] check_code, tries_code;
wire [2:0] address;

//wire on = SW[0];
register_file f1(
	.WRITE_CHECK(write_check),
	.WRITE_TRY(write_try),
	.CLOCK(~VGA_CTRL_CLK),
	.CHECK_ADD(check_address1),
	.CHECK_RGB(check_rgb),
	.TRIES_RANDS_ADD(tries_address1),
	.TRIES_RANDS_RGB(tries_rands_rgb),
	.CHECK_RGB_ADD(check_code),
	.TRIES_RANDS_RGB_ADD(tries_code)
);	
assign address = ct? tries_code: check_code;
Decoder d1(
	.CLOCK(~VGA_CTRL_CLK),
	.color_add(address),
	.blue(blue1),
	.green(green1),
	.red(red1)
);


rng r1(
	.CLOCK(~VGA_CTRL_CLK),
	.COUNT_ON(count_enable),
	.COLOR_1(rand_color1),
	.COLOR_2(rand_color2),
	.COLOR_3(rand_color3),
	.COLOR_4(rand_color4),
);


assign mVGA_R = (~screen && s2)? red2 :  
					  (screen && s1 && ~write_check && ~write_try)? red1 : BLACK;
assign mVGA_G = (~screen && s2)? green2 :  
					  (screen && s1 && ~write_check && ~write_try)? green1 : BLACK;
assign mVGA_B = (~screen && s2)? blue2 :  
					  (screen && s1 && ~write_check && ~write_try)? blue1 : BLACK;
					  
					 
/*assign mVGA_R = (~on && s2)? red2 :  
					  (on && s1)? red1 : BLACK;
assign mVGA_G = (~on && s2)? green2 :  
					  (on && s1)? green1 : BLACK;
assign mVGA_B = (~on && s2)? blue2 :  
					  (on && s1)? blue1 : BLACK;*/
							
endmodule //top module