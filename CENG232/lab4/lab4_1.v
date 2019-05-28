`timescale 1ns / 1ps
module MaskROM (input [3:0] RomAddress, output reg[7:0] RomDataOut);
/*  Please write your code below  */

	always @(RomAddress)
		begin
			case(RomAddress)
				4'd0: RomDataOut = 8'b00000000;
				4'd1: RomDataOut = 8'b00001111;
				4'd2: RomDataOut = 8'b00011110;
				4'd3: RomDataOut = 8'b00110000;
				4'd4: RomDataOut = 8'b01010000;
				4'd5: RomDataOut = 8'b01100110;
				4'd6: RomDataOut = 8'b01101010;
				4'd7: RomDataOut = 8'b01111110;
				4'd8: RomDataOut = 8'b10000001;
				4'd9: RomDataOut = 8'b10100000;
				4'd10: RomDataOut = 8'b10100110;
				4'd11: RomDataOut = 8'b10111101;
				4'd12: RomDataOut = 8'b11000000;
				4'd13: RomDataOut = 8'b11010000;
				4'd14: RomDataOut = 8'b11010011;
				4'd15: RomDataOut = 8'b11100110;
			endcase
		end
/*  Please write your code above  */
endmodule


/*mode 0:read, 1:write*/																							
module RgbRAM (input Mode,input [3:0] RamAddress, input [23:0] RamDataIn,
					input [7:0] Mask,input [2:0] Op, input CLK, output reg [23:0] RamDataOut);
/*  Please write your code below  */
	reg [0:23] myRam [0:15];
	reg [0:23] tMask;
	reg [0:8] tempR;
	reg [0:8] tempG;
	reg [0:8] tempB;
	reg trigger;
	integer i=0;
	initial begin
		for(i=0;i<16;i=i+1) 
			begin
				myRam[i]=24'd0;
			end
		RamDataOut = 24'd0;
		trigger = 0;
		tMask[0:7] = Mask;
		tMask[8:15] = Mask;
		tMask[16:23] = Mask;
		tempR = 9'd0;
		tempG = 9'd0;
		tempB = 9'd0;
	end
	
	always @(posedge CLK) begin
		if (Mode == 1) begin
			tMask[0:7] = Mask;
			tMask[8:15] = Mask;
			tMask[16:23] = Mask;
			/*$display("triple mask: %b",tMask);*/
			tempR = 9'd0;
			tempG = 9'd0;
			tempB = 9'd0;
			/*trigger = ~trigger;*/
			case (Op)
				3'd0 : 
					begin
					/*bitwise and */
						RamDataOut <= RamDataIn & tMask;
						myRam[RamAddress] <= RamDataIn & tMask;
					end
				3'd1 :
					begin
					/*bitwise or */
						RamDataOut <= RamDataIn | tMask;
						myRam[RamAddress] <= RamDataIn | tMask;
					end
				3'd2 : 
					begin
					/*bitwise xor*/
						RamDataOut <= RamDataIn ^ tMask;
						myRam[RamAddress] <= RamDataIn ^ tMask;
					end
				3'd3 :
					begin
					/*add */
						tempR = RamDataIn[7:0] + Mask;
						tempG = RamDataIn[15:8] + Mask;
						tempB = RamDataIn[23:16] + Mask;
						if (tempR > 255) begin
							RamDataOut[7:0] <= 8'd255;
							myRam[RamAddress][16:23] = 8'd255;
						end
						else begin
							RamDataOut[7:0] <= RamDataIn[7:0] + Mask;
							myRam[RamAddress][16:23] = RamDataIn[7:0] + Mask;
						end
						
						if (tempG > 255) begin
							RamDataOut[15:8] <= 8'd255;
							myRam[RamAddress][8:15] = 8'd255;
						end
						else begin
							RamDataOut[15:8] <= RamDataIn[15:8] + Mask;
							myRam[RamAddress][8:15] = RamDataIn[15:8] + Mask;
						end
						
						if (tempB > 255) begin
							RamDataOut[23:16] <= 8'd255;
							myRam[RamAddress][0:7] = 8'd255;
						end
						else begin
							RamDataOut[23:16] <= RamDataIn[23:16] + Mask;
							myRam[RamAddress][0:7] = RamDataIn[23:16] + Mask;
						end
						
					end
				3'd4 :
					begin
					/*subtract*/
						if (Mask > RamDataIn[7:0]) begin
							RamDataOut[7:0] <= 8'd0;
							myRam[RamAddress][16:23] = 8'd0;
						end
						else begin
							RamDataOut[7:0] <= RamDataIn[7:0] - Mask;
							myRam[RamAddress][16:23] = RamDataIn[7:0] - Mask;
						end
						
						if (Mask > RamDataIn[15:8]) begin
							RamDataOut[15:8] <= 8'd0;
							myRam[RamAddress][8:15] = 8'd0;
						end
						else begin
							RamDataOut[15:8] <= RamDataIn[15:8] - Mask;
							myRam[RamAddress][8:15] = RamDataIn[15:8] - Mask;
						end
						
						if (Mask > RamDataIn[23:16]) begin
							RamDataOut[23:16] <= 8'd0;
							myRam[RamAddress][0:7] = 8'd0;
						end
						else begin
							RamDataOut[23:16] <= RamDataIn[23:16] - Mask;
							myRam[RamAddress][0:7] = RamDataIn[23:16] - Mask;
						end
					end
				3'd5 :
					begin
					/*increment*/
						if (RamDataIn[7:0] == 255) begin
							RamDataOut[7:0] <= 8'd255;
							myRam[RamAddress][16:23] = 8'd255;
						end
						else begin
							RamDataOut[7:0] <= RamDataIn[7:0] + 1;
							myRam[RamAddress][16:23] = RamDataIn[7:0] + 1;
						end
						
						if (RamDataIn[15:8] == 255) begin
							RamDataOut[15:8] <= 8'd255;
							myRam[RamAddress][8:15] = 8'd255;
						end
						else begin
							RamDataOut[15:8] <= RamDataIn[15:8] + 1;
							myRam[RamAddress][8:15] = RamDataIn[15:8] + 1;
						end
						
						if (RamDataIn[23:16] == 255) begin
							RamDataOut[23:16] <= 8'd255;
							myRam[RamAddress][0:7] = 8'd255;
						end
						else begin
							RamDataOut[23:16] <= RamDataIn[23:16] + 1;
							myRam[RamAddress][0:7] = RamDataIn[23:16] + 1;
						end
						
					end
				3'd6 :
					begin
					/*decrement*/
						if (RamDataIn[7:0] == 0) begin
							RamDataOut[7:0] <= 8'd0;
							myRam[RamAddress][16:23] = 8'd0;
						end
						else begin
							RamDataOut[7:0] <= RamDataIn[7:0] - 1;
							myRam[RamAddress][16:23] = RamDataIn[7:0] - 1;
						end
						
						if (RamDataIn[15:8] == 0) begin
							RamDataOut[15:8] <= 8'd0;
							myRam[RamAddress][8:15] = 8'd0;
						end
						else begin
							RamDataOut[15:8] <= RamDataIn[15:8] - 1;
							myRam[RamAddress][8:15] = RamDataIn[15:8] - 1;
						end
						
						if (RamDataIn[23:16] == 0) begin
							RamDataOut[23:16] <= 8'd0;
							myRam[RamAddress][0:7] = 8'd0;
						end
						else begin
							RamDataOut[23:16] <= RamDataIn[23:16] - 1;
							myRam[RamAddress][0:7] = RamDataIn[23:16] - 1;
						end
					end
				3'd7 :
					begin
					/* rotate left */
						/*tempR = RamDataIn[7:1] + RamDataIn[1:0]*128;
						tempG = RamDataIn[15:9] + RamDataIn[9:8]*128;
						tempB = RamDataIn[23:17] + RamDataIn[17:16]*128;*/
						
						RamDataOut[7:1] <= RamDataIn[6:0];
						RamDataOut[0] <= RamDataIn[7];
						
						
						RamDataOut[15:9] <= RamDataIn[14:8];
						RamDataOut[8] <= RamDataIn[15];
						/*myRam[RamAddress][8:9] = RamDataIn[15:14];
						myRam[RamAddress][9:15] = RamDataIn[14:8];*/
						
						RamDataOut[23:17] <= RamDataIn[22:16];
						RamDataOut[16] <= RamDataIn[23];
						/*myRam[RamAddress][16:17] = RamDataIn[23:22];
						myRam[RamAddress][23:23] = RamDataIn[22:16];*/
						
						/*myRam[RamAddress][0:7] = {RamDataIn[7:6], RamDataIn[6:0]};*/
						
						myRam[RamAddress] = { RamDataIn[22:16], RamDataIn[23], RamDataIn[14:8],  RamDataIn[15],  RamDataIn[6:0], RamDataIn[7]};
						
					end
			endcase
			
		end
	end
	
	always @(Mode or RamAddress) begin
		if (Mode == 0) begin
			/*trigger = ~trigger;*/
			RamDataOut = myRam[RamAddress];
		end
	end
	

/*  Please write your code above  */
endmodule


module RgbMaskModule(input Mode, input [3:0] Address, input [23:0] RGBin,input [2:0] Op,  input CLK, output wire [23:0] RGBout);
	
	/*  DO NOT edit this module  */
	
	wire [7:0]  romResult;

	MaskROM RO(Address, romResult);
	RgbRAM RA(Mode, Address, RGBin,romResult, Op, CLK, RGBout);
endmodule
