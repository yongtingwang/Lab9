`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Chun You, Yang
// Create Date:    16:20 05/19/2015 
// Module Name:    sound_setting 
//////////////////////////////////////////////////////////////////////////////////
module sound_setting(
	in_note,
	in_vol,
	clk,
	clk_cnt,
	rst,
	note_data,
	vol_level,
	vol_data,
	pressed
);

	input [2:0] in_note;
	input [1:0] in_vol;
	input clk, clk_cnt;
	input rst;
	output reg [19:0] note_data;
	output reg [31:0] vol_data;
	output reg [3:0] vol_level;
	output pressed;
	reg [3:0] vol_level_next;
	reg [31:0] vol_data_next;

	// Note Control
	always @*
	begin
		if(in_note[0])   //DO
			note_data = 20'd76628;
		else if (in_note[1])   //RE
			note_data = 20'd68259;
		else if(in_note[2])    //MI
			note_data = 20'd60606;
		else
			note_data = 20'd0;
	end

	// Pressed Control
	assign pressed = in_note[0] || in_note[1] || in_note[2];

	// Volume Control
	always @*
	begin
		if (in_vol[0])   //加音量
		begin
			vol_level_next = vol_level + 1'd1;   //14SD
			vol_data_next[31:16] = vol_data[31:16] + 16'h400;
			vol_data_next[15:0] = vol_data[15:0] - 16'h400;
		end
		else if (in_vol[1])   //減音量
		begin
			vol_level_next = vol_level - 1'd1;
			vol_data_next[31:16] = vol_data[31:16] - 16'h400;
			vol_data_next[15:0] = vol_data[15:0] + 16'h400;
		end
		else
		begin
			vol_level_next = vol_level;
			vol_data_next = vol_data;
		end
	end

	always @(posedge clk_cnt or posedge rst) begin
		if(rst)
		begin
			vol_level <= 4'd0;
			vol_data <= {16'h0000, 16'h0000};
		end
		else
		begin
			vol_level <= vol_level_next;
			vol_data <= vol_data_next;
		end
	end

endmodule
