`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:23:25 09/22/2015 
// Design Name: 
// Module Name:    count 
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
module count(
	in2,
	in3,
	clk,
	rst_n,
	S4,
	S5
    );
input clk,rst_n,S4,S5;
output reg [3:0] in2,in3;
reg [3:0] in2_temp,in3_temp;


always@* 
	if(S4&&in2==4'd1&&in3==4'd6)begin
		in2_temp=in2;
		in3_temp=in3;
		end
	else if (S4&&in2==4'd0&&in3==4'd9)begin
		in2_temp=4'd1;
		in3_temp=0;
		end
	else if (S4)begin
		in2_temp=in2;
		in3_temp=in3+1'b1;
		end
	else if (S5&&in2==0&&in3==0)begin
		in2_temp=in2;
		in3_temp=in3;		
		end
	else if (S5&&in2==4'd1&&in3==0) begin
		in2_temp=0;
		in3_temp=4'd9;
		end
	else if(S5) begin
		in2_temp=in2;
		in3_temp=in3-1'b1;
		end
	else begin
		in2_temp=in2;
		in3_temp=in3;
	end

always@(posedge clk or negedge rst_n)
if(~rst_n) begin
	in2 <=0;
	in3 <=0;
	end
else begin
	in2 <=in2_temp;
	in3 <=in3_temp;
	end


endmodule
