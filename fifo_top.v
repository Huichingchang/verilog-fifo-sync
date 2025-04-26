`timescale 1ns/1ps
module fifo_top #(
	parameter DATA_WIDTH = 8, //每筆資料寬度
	parameter DEPTH = 16      //FIFO深度
)(
	input wire clk,           //時脈
	input wire rst,           //非同步重置
	input wire wr_en,         //寫入使能
	input wire rd_en,         //讀取使能
	input wire [DATA_WIDTH-1:0] din, //輸入資料
	output wire [DATA_WIDTH-1:0] dout, //輸出資料
	output wire full,  //FIFO滿了
	output wire empty  //FIFO空了
);

   //內部連接線
	wire [$clog2(DEPTH)-1:0] wr_addr;
	wire [$clog2(DEPTH)-1:0] rd_addr;
	
	//實例化控制器
	fifo_ctrl #(
		.DEPTH(DEPTH)
	) u_ctr1(
		.clk(clk),
		.rst(rst),
		.wr_en(wr_en),
		.rd_en(rd_en),
		.wr_addr(wr_addr),
		.rd_addr(rd_addr),
		.full(full),
		.empty(empty)
	);
	
	//實例化記憶體
	fifo_mem #(
		.DATA_WIDTH(DATA_WIDTH),
		.DEPTH(DEPTH)
	) u_mem (
		.clk(clk),
		.wr_en(wr_en),
		.rd_en(rd_en),
		.wr_addr(wr_addr),
		.rd_addr(rd_addr),
		.din(din),
		.dout(dout)
	);
endmodule