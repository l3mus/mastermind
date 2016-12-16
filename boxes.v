module boxes(
	input iCLK1,iCLK2,
	input [9:0] px,
	input [9:0] py,
	output reg [5:0]  oCheck_Address,
	output reg [5:0] oTries_Address,
	output reg oCheck_or_Try, //High for tries low for check
	output reg valid,
	output pixel
);


parameter COLS = 4;
parameter ROWS = 11;
parameter box_width = 30;
parameter box_height = 30;
parameter box_spacex = 15;
parameter box_spacey = 10;
parameter checks_width = 12;
parameter checks_height = 12;
parameter checks_spacex = 20;
parameter checks_spacey = 18; 


parameter row_pos = 15;
parameter col_pos = 15;
// test that we are inside the textbox
always @(negedge iCLK1)
	begin 
		//First Row (ANSWER)
		if(px>col_pos && px<(col_pos+box_width) && py>row_pos && py<(row_pos+box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 43;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>row_pos && py<(row_pos+box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 42;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>row_pos && py<(row_pos+box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 41;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>row_pos && py<(row_pos+box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 40;
				oCheck_or_Try <= 1'b1;
		//Second Row
		end else if(px>col_pos && px<(col_pos+box_width) && py>(row_pos+box_height+box_spacey) && py<((row_pos+box_height+box_spacey) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 39;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>(row_pos+box_height+box_spacey) && py<((row_pos+box_height+box_spacey) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 38;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>(row_pos+box_height+box_spacey) && py<((row_pos+box_height+box_spacey) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 37;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>(row_pos+box_height+box_spacey) && py<((row_pos+box_height+box_spacey) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 36;
				oCheck_or_Try <= 1'b1;
		//Second Row Tries 
		end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width)) 
					&& py>(row_pos+box_height+box_spacey) && py<(row_pos+checks_height+box_height+box_spacey)) begin
				valid <= 1'b1;
				oCheck_Address <= 39;
				oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
					&& py>(row_pos+box_height+box_spacey) && py<(row_pos+checks_height+box_height+box_spacey)) begin
				valid <= 1'b1;
				oCheck_Address <= 38;
				oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex  && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
					&& py>(row_pos+box_height+box_spacey+checks_spacey) && py<(row_pos+checks_height+box_height+box_spacey+checks_spacey)) begin
			valid <= 1'b1;
			oCheck_Address <= 37;
			oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width))
					&& py>(row_pos+box_height+box_spacey+checks_spacey) && py<(row_pos+checks_height+box_height+box_spacey+checks_spacey)) begin
			valid <= 1'b1;
			oCheck_Address <= 36;
			oCheck_or_Try <= 1'b0;
         //Third Row
         end else if(px>col_pos && px<(col_pos+box_width) && py>(row_pos+2*(box_height+box_spacey)) && py<((row_pos+2*(box_height+box_spacey)) +box_height)) begin
         		valid <= 1'b1;
         		oTries_Address <= 35;
         		oCheck_or_Try <= 1'b1;
         end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>(row_pos+2*(box_height+box_spacey)) && py<((row_pos+2*(box_height+box_spacey)) +box_height)) begin
         		valid <= 1'b1;
         		oTries_Address <= 34;
         		oCheck_or_Try <= 1'b1;
         end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>(row_pos+2*(box_height+box_spacey)) && py<((row_pos+2*(box_height+box_spacey)) +box_height)) begin
         		valid <= 1'b1;
         		oTries_Address <= 33;
         		oCheck_or_Try <= 1'b1;
         end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>(row_pos+2*(box_height+box_spacey)) && py<((row_pos+2*(box_height+box_spacey)) +box_height)) begin
         		valid <= 1'b1;
         		oTries_Address <= 32;
         		oCheck_or_Try <= 1'b1;
         //Third Row Tries 
         end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width)) 
         			&& py>(row_pos+2*(box_height+box_spacey)) && py<(row_pos+checks_height+2*(box_height+box_spacey))) begin
         		valid <= 1'b1;
         		oCheck_Address <= 35;
         		oCheck_or_Try <= 1'b0;
         end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
         			&& py>(row_pos+2*(box_height+box_spacey)) && py<(row_pos+checks_height+2*(box_height+box_spacey))) begin
         		valid <= 1'b1;
         		oCheck_Address <= 34;
         		oCheck_or_Try <= 1'b0;
         end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex  && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
         			&& py>(row_pos+2*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+2*(box_height+box_spacey)+checks_spacey)) begin
         	valid <= 1'b1;
         	oCheck_Address <= 33;
         	oCheck_or_Try <= 1'b0;
         end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width))
         			&& py>(row_pos+2*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+2*(box_height+box_spacey)+checks_spacey)) begin
         	valid <= 1'b1;
         	oCheck_Address <= 32;
         	oCheck_or_Try <= 1'b0;
         //Fourth Row
         end else if(px>col_pos && px<(col_pos+box_width) && py>(row_pos+3*(box_height+box_spacey)) && py<((row_pos+3*(box_height+box_spacey)) +box_height)) begin
         		valid <= 1'b1;
         		oTries_Address <= 31;
         		oCheck_or_Try <= 1'b1;
         end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>(row_pos+3*(box_height+box_spacey)) && py<((row_pos+3*(box_height+box_spacey)) +box_height)) begin
         		valid <= 1'b1;
         		oTries_Address <= 30;
         		oCheck_or_Try <= 1'b1;
         end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>(row_pos+3*(box_height+box_spacey)) && py<((row_pos+3*(box_height+box_spacey)) +box_height)) begin
         		valid <= 1'b1;
         		oTries_Address <= 29;
         		oCheck_or_Try <= 1'b1;
         end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>(row_pos+3*(box_height+box_spacey)) && py<((row_pos+3*(box_height+box_spacey)) +box_height)) begin
         		valid <= 1'b1;
         		oTries_Address <= 28;
         		oCheck_or_Try <= 1'b1;
         //Fourth Row Tries 
			end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width)) 
						&& py>(row_pos+3*(box_height+box_spacey)) && py<(row_pos+checks_height+3*(box_height+box_spacey))) begin
					valid <= 1'b1;
					oCheck_Address <= 31;
					oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
						&& py>(row_pos+3*(box_height+box_spacey)) && py<(row_pos+checks_height+3*(box_height+box_spacey))) begin
					valid <= 1'b1;
					oCheck_Address <= 30;
					oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex  && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
						&& py>(row_pos+3*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+3*(box_height+box_spacey)+checks_spacey)) begin
				valid <= 1'b1;
				oCheck_Address <= 29;
				oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width))
						&& py>(row_pos+3*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+3*(box_height+box_spacey)+checks_spacey)) begin
				valid <= 1'b1;
				oCheck_Address <= 28;
				oCheck_or_Try <= 1'b0;
	//Fifth Row
	end else if(px>col_pos && px<(col_pos+box_width) && py>(row_pos+4*(box_height+box_spacey)) && py<((row_pos+4*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 27;
			oCheck_or_Try <= 1'b1;
	end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>(row_pos+4*(box_height+box_spacey)) && py<((row_pos+4*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 26;
			oCheck_or_Try <= 1'b1;
	end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>(row_pos+4*(box_height+box_spacey)) && py<((row_pos+4*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 25;
			oCheck_or_Try <= 1'b1;
	end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>(row_pos+4*(box_height+box_spacey)) && py<((row_pos+4*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 24;
			oCheck_or_Try <= 1'b1;
	//Fifth Row Tries 
			end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width)) 
						&& py>(row_pos+4*(box_height+box_spacey)) && py<(row_pos+checks_height+4*(box_height+box_spacey))) begin
					valid <= 1'b1;
					oCheck_Address <= 27;
					oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
						&& py>(row_pos+4*(box_height+box_spacey)) && py<(row_pos+checks_height+4*(box_height+box_spacey))) begin
					valid <= 1'b1;
					oCheck_Address <= 26;
					oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex  && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
						&& py>(row_pos+4*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+4*(box_height+box_spacey)+checks_spacey)) begin
				valid <= 1'b1;
				oCheck_Address <= 25;
				oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width))
						&& py>(row_pos+4*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+4*(box_height+box_spacey)+checks_spacey)) begin
				valid <= 1'b1;
				oCheck_Address <= 24;
				oCheck_or_Try <= 1'b0;
	//Sixth Row
	end else if(px>col_pos && px<(col_pos+box_width) && py>(row_pos+5*(box_height+box_spacey)) && py<((row_pos+5*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 23;
			oCheck_or_Try <= 1'b1;
	end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>(row_pos+5*(box_height+box_spacey)) && py<((row_pos+5*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 22;
			oCheck_or_Try <= 1'b1;
	end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>(row_pos+5*(box_height+box_spacey)) && py<((row_pos+5*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 21;
			oCheck_or_Try <= 1'b1;
	end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>(row_pos+5*(box_height+box_spacey)) && py<((row_pos+5*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 20;
			oCheck_or_Try <= 1'b1;
	//Sixth Row Tries 
			end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width)) 
						&& py>(row_pos+5*(box_height+box_spacey)) && py<(row_pos+checks_height+5*(box_height+box_spacey))) begin
					valid <= 1'b1;
					oCheck_Address <= 23;
					oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
						&& py>(row_pos+5*(box_height+box_spacey)) && py<(row_pos+checks_height+5*(box_height+box_spacey))) begin
					valid <= 1'b1;
					oCheck_Address <= 22;
					oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex  && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
						&& py>(row_pos+5*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+5*(box_height+box_spacey)+checks_spacey)) begin
				valid <= 1'b1;
				oCheck_Address <= 21;
				oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width))
						&& py>(row_pos+5*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+5*(box_height+box_spacey)+checks_spacey)) begin
				valid <= 1'b1;
				oCheck_Address <= 20;
				oCheck_or_Try <= 1'b0;
	//Seventh Row
	end else if(px>col_pos && px<(col_pos+box_width) && py>(row_pos+6*(box_height+box_spacey)) && py<((row_pos+6*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 19;
			oCheck_or_Try <= 1'b1;
	end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>(row_pos+6*(box_height+box_spacey)) && py<((row_pos+6*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 18;
			oCheck_or_Try <= 1'b1;
	end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>(row_pos+6*(box_height+box_spacey)) && py<((row_pos+6*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 17;
			oCheck_or_Try <= 1'b1;
	end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>(row_pos+6*(box_height+box_spacey)) && py<((row_pos+6*(box_height+box_spacey)) +box_height)) begin
			valid <= 1'b1;
			oTries_Address <= 16;
			oCheck_or_Try <= 1'b1;
			
	//Seventh Row Tries 
			end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width)) 
						&& py>(row_pos+6*(box_height+box_spacey)) && py<(row_pos+checks_height+6*(box_height+box_spacey))) begin
					valid <= 1'b1;
					oCheck_Address <= 19;
					oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
						&& py>(row_pos+6*(box_height+box_spacey)) && py<(row_pos+checks_height+6*(box_height+box_spacey))) begin
					valid <= 1'b1;
					oCheck_Address <= 18;
					oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex  && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
						&& py>(row_pos+6*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+6*(box_height+box_spacey)+checks_spacey)) begin
				valid <= 1'b1;
				oCheck_Address <= 17;
				oCheck_or_Try <= 1'b0;
			end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width))
						&& py>(row_pos+6*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+6*(box_height+box_spacey)+checks_spacey)) begin
				valid <= 1'b1;
				oCheck_Address <= 16;
				oCheck_or_Try <= 1'b0;
		//Eigth Row
		end else if(px>col_pos && px<(col_pos+box_width) && py>(row_pos+7*(box_height+box_spacey)) && py<((row_pos+7*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 15;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>(row_pos+7*(box_height+box_spacey)) && py<((row_pos+7*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 14;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>(row_pos+7*(box_height+box_spacey)) && py<((row_pos+7*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 13;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>(row_pos+7*(box_height+box_spacey)) && py<((row_pos+7*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 12;
				oCheck_or_Try <= 1'b1;
		//Eigth Row Tries 
		end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width)) 
					&& py>(row_pos+7*(box_height+box_spacey)) && py<(row_pos+checks_height+7*(box_height+box_spacey))) begin
				valid <= 1'b1;
				oCheck_Address <= 15;
				oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
					&& py>(row_pos+7*(box_height+box_spacey)) && py<(row_pos+checks_height+7*(box_height+box_spacey))) begin
				valid <= 1'b1;
				oCheck_Address <= 14;
				oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex  && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
					&& py>(row_pos+7*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+7*(box_height+box_spacey)+checks_spacey)) begin
			valid <= 1'b1;
			oCheck_Address <= 13;
			oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width))
					&& py>(row_pos+7*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+7*(box_height+box_spacey)+checks_spacey)) begin
			valid <= 1'b1;
			oCheck_Address <= 12;
			oCheck_or_Try <= 1'b0;
		//Nineth Row
		end else if(px>col_pos && px<(col_pos+box_width) && py>(row_pos+8*(box_height+box_spacey)) && py<((row_pos+8*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 11;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>(row_pos+8*(box_height+box_spacey)) && py<((row_pos+8*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 10;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>(row_pos+8*(box_height+box_spacey)) && py<((row_pos+8*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 9;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>(row_pos+8*(box_height+box_spacey)) && py<((row_pos+8*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 8;
				oCheck_or_Try <= 1'b1;
		//Nineth Row Tries 
		end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width)) 
					&& py>(row_pos+8*(box_height+box_spacey)) && py<(row_pos+checks_height+8*(box_height+box_spacey))) begin
				valid <= 1'b1;
				oCheck_Address <= 11;
				oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
					&& py>(row_pos+8*(box_height+box_spacey)) && py<(row_pos+checks_height+8*(box_height+box_spacey))) begin
				valid <= 1'b1;
				oCheck_Address <= 10;
				oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex  && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
					&& py>(row_pos+8*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+8*(box_height+box_spacey)+checks_spacey)) begin
			valid <= 1'b1;
			oCheck_Address <= 9;
			oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width))
					&& py>(row_pos+8*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+8*(box_height+box_spacey)+checks_spacey)) begin
			valid <= 1'b1;
			oCheck_Address <= 8;
			oCheck_or_Try <= 1'b0;
		
		//Tenth Row
		end else if(px>col_pos && px<(col_pos+box_width) && py>(row_pos+9*(box_height+box_spacey)) && py<((row_pos+9*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 7;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>(row_pos+9*(box_height+box_spacey)) && py<((row_pos+9*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 6;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>(row_pos+9*(box_height+box_spacey)) && py<((row_pos+9*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 5;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>(row_pos+9*(box_height+box_spacey)) && py<((row_pos+9*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 4;
				oCheck_or_Try <= 1'b1;
		//Tenth Row Tries
		end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width)) 
					&& py>(row_pos+9*(box_height+box_spacey)) && py<(row_pos+checks_height+9*(box_height+box_spacey))) begin
				valid <= 1'b1;
				oCheck_Address <= 7;
				oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
					&& py>(row_pos+9*(box_height+box_spacey)) && py<(row_pos+checks_height+9*(box_height+box_spacey))) begin
				valid <= 1'b1;
				oCheck_Address <= 6;
				oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex  && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
					&& py>(row_pos+9*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+9*(box_height+box_spacey)+checks_spacey)) begin
			valid <= 1'b1;
			oCheck_Address <= 5;
			oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width))
					&& py>(row_pos+9*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+9*(box_height+box_spacey)+checks_spacey)) begin
			valid <= 1'b1;
			oCheck_Address <= 4;
			oCheck_or_Try <= 1'b0;
		//Eleventh Row 
		end else if(px>col_pos && px<(col_pos+box_width) && py>(row_pos+10*(box_height+box_spacey)) && py<((row_pos+10*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 3;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+box_width+box_spacex) && px<((col_pos+box_width+box_spacex)+box_width) && py>(row_pos+10*(box_height+box_spacey)) && py<((row_pos+10*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 2;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+2*(box_width+box_spacex)) && px<((col_pos+2*(box_width+box_spacex)) +box_width) && py>(row_pos+10*(box_height+box_spacey)) && py<((row_pos+10*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 1;
				oCheck_or_Try <= 1'b1;
		end else if(px>(col_pos+3*(box_width+box_spacex)) && px<((col_pos+3*(box_width+box_spacex)) +box_width) && py>(row_pos+10*(box_height+box_spacey)) && py<((row_pos+10*(box_height+box_spacey)) +box_height)) begin
				valid <= 1'b1;
				oTries_Address <= 0;
				oCheck_or_Try <= 1'b1;
		//Eleventh Row Tries 
		end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width)) 
					&& py>(row_pos+10*(box_height+box_spacey)) && py<(row_pos+checks_height+10*(box_height+box_spacey))) begin
				valid <= 1'b1;
				oCheck_Address <= 3;
				oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
					&& py>(row_pos+10*(box_height+box_spacey)) && py<(row_pos+checks_height+10*(box_height+box_spacey))) begin
				valid <= 1'b1;
				oCheck_Address <= 2;
				oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex)+checks_spacex  && px<((col_pos+4*(box_width+box_spacex)+checks_spacex+checks_width)) 
					&& py>(row_pos+10*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+10*(box_height+box_spacey)+checks_spacey)) begin
			valid <= 1'b1;
			oCheck_Address <= 1;
			oCheck_or_Try <= 1'b0;
		end else if(px>col_pos+4*(box_width+box_spacex) && px<((col_pos+4*(box_width+box_spacex)+checks_width))
					&& py>(row_pos+10*(box_height+box_spacey)+checks_spacey) && py<(row_pos+checks_height+10*(box_height+box_spacey)+checks_spacey)) begin
			valid <= 1'b1;
			oCheck_Address <= 0;
			oCheck_or_Try <= 1'b0;
		end else begin	
				valid <= 1'b0;
		end
		
	end
	assign pixel = 1'b1;
	
endmodule