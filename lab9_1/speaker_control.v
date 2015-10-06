`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:11:32 09/21/2015 
// Design Name: 
// Module Name:    speaker_control 
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
module speaker_control(
	clk,
	rst_n,
	audio_in_left,
	audio_in_right, 
	audio_appsel,   // =1'b1 (stereo playing)
	audio_sysclk,   //40MHz (from external crystal LOC = R10)  ==clk
	audio_bck,   //5MHz (bit clock of audio data)
	audio_ws,    //1/0 (left/right, (5/32) MHz sampling rate)
	audio_data   //16'h8000(min) ~ 16'h7FFF (max) (2's complement)
    );
input [15:0] audio_in_left,audio_in_right;
input clk,rst_n;
output reg audio_bck,audio_ws,audio_data;
output audio_appsel,audio_sysclk;

reg audio_bck_next;
	reg audio_ws_next;
	reg [3:0] audio_bck_cnt;
	reg [3:0] audio_bck_cnt_next;
	reg [1:0] cnt_4, cnt_4_next;
	reg [6:0] clk_128, clk_128_next;

	// audio_appsel
	assign audio_appsel = 1'b1;

	// audio_sysclk
	assign audio_sysclk = clk;

	// audio_bck
	always @*
		if (cnt_4 == 2'd3)
		begin
			cnt_4_next = 2'd0;
			audio_bck_next = ~audio_bck;
		end
		else
		begin
			cnt_4_next = cnt_4 + 1'b1;
			audio_bck_next = audio_bck;
		end

	always @(posedge clk or negedge rst_n)
		if (~rst_n)
		begin
			cnt_4 <= 2'b0;
			audio_bck <= 1'b0;
		end
		else
		begin
			cnt_4 <= cnt_4_next;
			audio_bck <= audio_bck_next;
		end

	// audio_ws
	always @*
		if (clk_128 == 7'd127)
		begin
			clk_128_next = 7'd0;
			audio_ws_next = ~audio_ws;
		end
		else
		begin
			clk_128_next = clk_128 + 1'b1;
			audio_ws_next = audio_ws;
		end

	always @(posedge clk or negedge rst_n)
		if (~rst_n)
		begin
			clk_128 <= 7'd0;
			audio_ws <= 1'b0;
		end
		else
		begin
			clk_128 <= clk_128_next;
			audio_ws <= audio_ws_next;
		end

	// audio_bck_cnt
	always @*
	begin
		audio_bck_cnt_next = audio_bck_cnt + 1'b1;
	end

	always @(negedge audio_bck or negedge rst_n)
	begin
		if (~rst_n)
		begin
			audio_bck_cnt = 4'b0;
		end
		else
		begin
			audio_bck_cnt = audio_bck_cnt_next;
		end
	end

	// audio_data
	always @*
	case({audio_ws,audio_bck_cnt})
		5'b1_0000: audio_data = audio_in_left[15];
		5'b1_0001: audio_data = audio_in_left[14];
		5'b1_0010: audio_data = audio_in_left[13];
		5'b1_0011: audio_data = audio_in_left[12];
		5'b1_0100: audio_data = audio_in_left[11];
		5'b1_0101: audio_data = audio_in_left[10];
		5'b1_0110: audio_data = audio_in_left[9];
		5'b1_0111: audio_data = audio_in_left[8];
		5'b1_1000: audio_data = audio_in_left[7];
		5'b1_1001: audio_data = audio_in_left[6];
		5'b1_1010: audio_data = audio_in_left[5];
		5'b1_1011: audio_data = audio_in_left[4];
		5'b1_1100: audio_data = audio_in_left[3];
		5'b1_1101: audio_data = audio_in_left[2];
		5'b1_1110: audio_data = audio_in_left[1];
		5'b1_1111: audio_data = audio_in_left[0];
		5'b0_0000: audio_data = audio_in_right[15];
		5'b0_0001: audio_data = audio_in_right[14];
		5'b0_0010: audio_data = audio_in_right[13];
		5'b0_0011: audio_data = audio_in_right[12];
		5'b0_0100: audio_data = audio_in_right[11];
		5'b0_0101: audio_data = audio_in_right[10];
		5'b0_0110: audio_data = audio_in_right[9];
		5'b0_0111: audio_data = audio_in_right[8];
		5'b0_1000: audio_data = audio_in_right[7];
		5'b0_1001: audio_data = audio_in_right[6];
		5'b0_1010: audio_data = audio_in_right[5]; 
		5'b0_1011: audio_data = audio_in_right[4];
		5'b0_1100: audio_data = audio_in_right[3];
		5'b0_1101: audio_data = audio_in_right[2];
		5'b0_1110: audio_data = audio_in_right[1];
		5'b0_1111: audio_data = audio_in_right[0];
		default: audio_data = 1'b0;
	endcase

endmodule
