`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Chun You, Yang
// Create Date:    16:32 05/14/2015 
// Module Name:    speaker 
//////////////////////////////////////////////////////////////////////////////////
module speaker(
	clk,
	pb_in_rst,
	pb_in_note,
	pb_in_vol,
	audio_appsel,
	audio_sysclk,
	audio_bck,
	audio_ws,
	audio_data,
	display
);

	input clk;
	input pb_in_rst;
	wire rst;
	assign rst = ~pb_in_rst;

	input [2:0] pb_in_note;
	input [1:0] pb_in_vol;
	wire [2:0] in_note;
	wire [1:0] in_vol;

	wire [19:0] note_data;
	wire [31:0] vol_data;
	wire [15:0] audio_in_left, audio_in_right;
	output audio_appsel;
	output audio_sysclk;
	output audio_bck;
	output audio_ws;
	output audio_data;
	wire pressed;

	wire [1:0] clk_scn;
	wire [4:0] vol_level;
	wire [7:0] vol_bcd;
	wire [14:0] dispA, dispB;
	output [19:0] display;

	// Clock Process
	frequency_divider fteq_div(
		.clk_cnt(),
		.clk_scn(clk_scn),
		.clk(clk),
		.rst(rst)
	);

	// Button Preprocess
	push_button pb_vol_0(
		.clk(clk_scn[0]),
		.rst(rst),
		.pb_in(pb_in_vol[0]),
		.pb_out(in_vol[0]),
		.debounced()
	);
	push_button pb_vol_1(
		.clk(clk_scn[0]),
		.rst(rst),
		.pb_in(pb_in_vol[1]),
		.pb_out(in_vol[1]),
		.debounced()
	);
	debounce_circuit pb_note_0(
		.clk(clk_scn[0]),
		.rst(rst),
		.pb_in(pb_in_note[0]),
		.pb_debounced(in_note[0])
	);
	debounce_circuit pb_note_1(
		.clk(clk_scn[0]),
		.rst(rst),
		.pb_in(pb_in_note[1]),
		.pb_debounced(in_note[1])
	);
	debounce_circuit pb_note_2(
		.clk(clk_scn[0]),
		.rst(rst),
		.pb_in(pb_in_note[2]),
		.pb_debounced(in_note[2])
	);

	// Key and Volume Setting
	sound_setting voice_set(
		.in_note(in_note),
		.in_vol(in_vol),
		.clk(clk),
		.clk_cnt(clk_scn[0]),
		.rst(rst),
		.note_data(note_data),
		.vol_level(vol_level),
		.vol_data(vol_data),
		.pressed(pressed)
	);

	// Tone Generator
	buzzer_control buz_ctl(
		.clk(clk),
		.rst(rst),
		.note_div(note_data),
		.vol_data(vol_data),
		.audio_left(audio_in_left),
		.audio_right(audio_in_right)
	);

	// DAC Signal Generator
	speaker_control spk_ctl(
		.clk(clk),
		.rst(rst),
		.pressed(pressed),
		.audio_in_left(audio_in_left),
		.audio_in_right(audio_in_right),
		.audio_appsel(audio_appsel),
		.audio_sysclk(audio_sysclk),
		.audio_bck(audio_bck),
		.audio_ws(audio_ws),
		.audio_data(audio_data)
	);

	// Volume Display
	BIN_converter_BCD ftsd_conv(
		.in({3'b000,vol_level}),
		.units(vol_bcd[3:0]),
		.tens(vol_bcd[7:4]),
		.hunds()
	);
	FTSD_decoder ftsd_dec_A(
		.bcd(vol_bcd[7:4]),
		.ftsd(dispA)
	);
	FTSD_decoder ftsd_dec_B(
		.bcd(vol_bcd[3:0]),
		.ftsd(dispB)
	);
	FTSD_scan ftsd_scn(
		.in1(0),
		.in2(0),
		.in3(dispA),
		.in4(dispB),
		.clk(clk_scn),
		.display(display)
	);
endmodule
