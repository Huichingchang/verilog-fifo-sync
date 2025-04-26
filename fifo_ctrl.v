`timescale 1ns/1ps
module fifo_ctrl #(
	parameter DEPTH = 16
)( 
	input wire clk,//時脈
	input wire rst, //非同步重置
	input wire wr_en, //寫入要求
	input wire rd_en, //讀取要求
	output reg[$clog2(DEPTH)-1:0] wr_addr, //寫入位址
	output reg[$clog2(DEPTH)-1:0] rd_addr, //讀取位址
	output reg full, //滿了
	output reg empty //空了
);

	reg [$clog2(DEPTH):0] fifo_cnt; //紀錄目前有幾筆資料(比地址多一位,因為要存到DEPTH)
	
	//FIFO計數器邏輯
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			fifo_cnt <= 0;
		end else begin
			case ({wr_en, rd_en})
				2'b10: fifo_cnt <= fifo_cnt + 1; //只寫
				2'b01: fifo_cnt <= fifo_cnt - 1; //只讀
				default: fifo_cnt <= fifo_cnt;   //其他狀況不變
			endcase
		end
	end
	
	//寫入位址管理
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			wr_addr <= 0;
		end else if(wr_en) begin
			wr_addr <= wr_addr +1;
		end
	end
	
	//讀取位址管理
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			rd_addr <= 0;
		end else if (rd_en) begin
			rd_addr <= rd_addr + 1;
		end
	end
	
	//判斷滿/空
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			full <= 0;
			empty <= 1;
		end else begin
			full <= (fifo_cnt == DEPTH);
			empty <= (fifo_cnt == 0);
	   end
   end
endmodule