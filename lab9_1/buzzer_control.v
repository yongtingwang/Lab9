`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:08:13 09/21/2015 
// Design Name: 
// Module Name:    buzzer_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module buzzer_control(
clk, // clock from crystal
rst_n, // active low reset
note_div, // div for note generation
audio_left, // left sound audio
audio_right // right sound audio
);
// I/O declaration
input clk; // clock from crystal
input rst_n; // active low reset
input [19:0] note_div; // div for note generation
output [15:0] audio_left; // left sound audio
output [15:0] audio_right; // right sound audio
// Declare internal signals
reg [19:0] clk_cnt_next, clk_cnt;
reg b_clk, b_clk_next;

// Note frequency generation
always @(posedge clk or negedge rst_n)
	if (~rst_n)
		begin
		clk_cnt <= 20'd0;
		b_clk <= 1'b0;
		end
	else
		begin
		clk_cnt <= clk_cnt_next;
		b_clk <= b_clk_next;
		end
always @*
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
// Assign the amplitude of the note 
assign audio_left = (b_clk == 1'b0) ? 16'h8000 : 16'h7FFF;
assign audio_right = (b_clk == 1'b0) ? 16'h8000 : 16'h7FFF;
endmodule