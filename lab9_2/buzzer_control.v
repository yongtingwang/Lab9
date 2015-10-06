`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Chun You, Yang
// Create Date:    16:23 05/14/2015 
// Module Name:    buzzer_control 
//////////////////////////////////////////////////////////////////////////////////
module buzzer_control(
	clk,
	rst,
	note_div,
	vol_data,
	audio_left,
	audio_right
);

	input clk;
	input rst;
	input [19:0] note_div;
	input [31:0] vol_data;
	output [15:0] audio_left, audio_right;

	reg [19:0] clk_cnt_next, clk_cnt;
	reg b_clk, b_clk_next;

	always @(posedge clk or posedge rst)
	begin
		if (rst)
		begin
			clk_cnt <= 20'd0;
			b_clk <= 1'b0;
		end
		else
		begin
			clk_cnt <= clk_cnt_next;
			b_clk <= b_clk_next;
		end
	end

	always @*
	begin
		if (clk_cnt == note_div)
		begin
			clk_cnt_next = 20'd0;
			b_clk_next = ~b_clk;
		end
		else
		begin
			clk_cnt_next = clk_cnt + 1'b1;
			b_clk_next = b_clk;
		end
	end

	assign audio_left = (b_clk == 1'b0) ? vol_data[15:0] : vol_data[31:16];
	assign audio_right = (b_clk == 1'b0) ? vol_data[15:0] : vol_data[31:16];
endmodule
