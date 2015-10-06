`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:19:47 09/22/2015 
// Design Name: 
// Module Name:    pick 
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
`include "global.v"
module pick(
	S1,
	S2,
	S3,
	sound_freq
    );
	 
input S3,S1,S2;
output [19:0]sound_freq;
reg [19:0]sound_freq;

always@(S3 or S1 or S2)
begin
  if(S1==1'b1 && S2==1'b0 && S3==1'b0 )
  sound_freq = 20'd76628;
  else if(S1==1'b0 && S2==1'b1 && S3==1'b0 )
  sound_freq = 20'd68259;
  else if(S1==1'b0 && S2==1'b0 && S3==1'b1 )
  sound_freq = 20'd60606;
  else  
  sound_freq = 20'd0;
  
end  
endmodule
