`timescale 1ns/1ps
module fifo_mem #(
    parameter DATA_WIDTH = 8,   // 每筆資料寬度（預設8位元）
    parameter DEPTH = 16        // FIFO深度（有幾格資料）
)(
    input wire clk,             // 系統時脈
    input wire wr_en,           // 寫入使能
    input wire rd_en,           // 讀出使能
    input wire [DATA_WIDTH-1:0] din,   // 要寫進去的資料
    input wire [$clog2(DEPTH)-1:0] wr_addr, // 寫入位置
    input wire [$clog2(DEPTH)-1:0] rd_addr, // 讀出位置
    output reg [DATA_WIDTH-1:0] dout    // 讀出資料
);

    // 記憶體陣列宣告
    reg [DATA_WIDTH-1:0] mem_array [0:DEPTH-1];

    // 寫入邏輯
    always @(posedge clk) begin
        if (wr_en) begin
            mem_array[wr_addr] <= din;
        end
    end

    // 讀出邏輯
    always @(posedge clk) begin
        if (rd_en) begin
            dout <= mem_array[rd_addr];
        end
    end

endmodule
