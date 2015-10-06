`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer		: Chun You, Yang
// Create Date	: 17:53 03/12/2015
// Module Name	: FTSD_decoder 
//////////////////////////////////////////////////////////////////////////////////
`include "global.v"
module FTSD_decoder(
	bcd,
	ftsd
);

	output reg [14:0]ftsd;
	input [5:0]bcd;

	always @*
		case(bcd)
			`FONT_ZERO: ftsd=`FTSD_ZERO;
			`FONT_ONE: ftsd=`FTSD_ONE;
			`FONT_TWO: ftsd=`FTSD_TWO;
			`FONT_THREE: ftsd=`FTSD_THREE;
			`FONT_FOUR: ftsd=`FTSD_FOUR;
			`FONT_FIVE: ftsd=`FTSD_FIVE;
			`FONT_SIX: ftsd=`FTSD_SIX;
			`FONT_SEVEN: ftsd=`FTSD_SEVEN;
			`FONT_EIGHT: ftsd=`FTSD_EIGHT;
			`FONT_NINE: ftsd=`FTSD_NINE;
			`FONT_A: ftsd=`FTSD_A;
			`FONT_B: ftsd=`FTSD_B;
			`FONT_C: ftsd=`FTSD_C;
			`FONT_D: ftsd=`FTSD_D;
			`FONT_E: ftsd=`FTSD_E;
			`FONT_F: ftsd=`FTSD_F;
			`FONT_G: ftsd=`FTSD_G;
			`FONT_H: ftsd=`FTSD_H;
			`FONT_I: ftsd=`FTSD_I;
			`FONT_J: ftsd=`FTSD_J;
			`FONT_K: ftsd=`FTSD_K;
			`FONT_L: ftsd=`FTSD_L;
			`FONT_M: ftsd=`FTSD_M;
			`FONT_N: ftsd=`FTSD_N;
			`FONT_O: ftsd=`FTSD_O;
			`FONT_P: ftsd=`FTSD_P;
			`FONT_Q: ftsd=`FTSD_Q;
			`FONT_R: ftsd=`FTSD_R;
			`FONT_S: ftsd=`FTSD_S;
			`FONT_T: ftsd=`FTSD_T;
			`FONT_U: ftsd=`FTSD_U;
			`FONT_V: ftsd=`FTSD_V;
			`FONT_W: ftsd=`FTSD_W;
			`FONT_X: ftsd=`FTSD_X;
			`FONT_Y: ftsd=`FTSD_Y;
			`FONT_Z: ftsd=`FTSD_Z;
			default: ftsd=`FTSD_DEFAULT;
		endcase

endmodule
