`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company		: NTHUEE
// Engineer		: Chun You, Yang
// Create Date	: 15:04 03/07/2012 
// Module Name	: frequency_divider
// Project Name	: Lab6_1
//////////////////////////////////////////////////////////////////////////////////
`include "global.v"
module frequency_divider(
	clk_cnt,
	clk_scn,
	clk,
	rst
);

	output clk_cnt;
	output [1:0] clk_scn;
	input clk;
	input rst;

	reg clk_cnt;
	reg [1:0] clk_scn;
	reg [14:0] cnt_l;
	reg [6:0] cnt_h;
	reg [`FREQ_DIV_BIT-1:0] cnt_tmp;

// Combinational block 
always @*
	cnt_tmp = {clk_cnt,cnt_h,clk_scn,cnt_l} + 1'b1;
	
// Sequential block 
always @(posedge clk or posedge rst)
	if (rst)
		{clk_cnt,cnt_h,clk_scn,cnt_l} <= `FREQ_DIV_BIT'b0;
	else
		{clk_cnt,cnt_h,clk_scn,cnt_l} <= cnt_tmp;

endmodule
