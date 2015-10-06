`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:16:44 09/22/2015 
// Design Name: 
// Module Name:    volume 
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
module volume(
	S4,
	S5,
	clk,
	rst_n,
	vol_data
    );
	 
input S4,S5,clk,rst_n;
output [31:0] vol_data;
reg [31:0] vol_data, vol_data_next;
//reg [3:0] vol_level_next;
always @*
	begin
		if (S4)
		begin
	//		vol_level_next = vol_level + 1'd1;
			vol_data_next[31:16] = vol_data[31:16] + 16'h400;
			vol_data_next[15:0] = vol_data[15:0] - 16'h400;
		end
		else if (S5)
		begin
	//		vol_level_next = vol_level - 1'd1;
			vol_data_next[31:16] = vol_data[31:16] - 16'h400;
			vol_data_next[15:0] = vol_data[15:0] + 16'h400;
		end
		else
		begin
	//		vol_level_next = vol_level;
			vol_data_next = vol_data;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n)
		begin
	//		vol_level <= 4'd0;
			vol_data <= {16'h0000, 16'h0000};
		end
		else
		begin
	//		vol_level <= vol_level_next;
			vol_data <= vol_data_next;
		end
	end


endmodule

