`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 20:57:22
// Design Name: 
// Module Name: dbu_tb_TA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dbu_tb_TA(

    );
    
    reg clk;  // ʱ��; ��������Ч
    reg rst;   // �첽��λ; �ߵ�ƽ��Ч
    reg [2:0] sel;
    reg mem_rf;
    reg step;
    reg succ;
    reg inc;
    reg dec;
    wire [7:0] an;
    wire [7:0] seg;
    wire [11:0] led;
    
    dbu dbu(clk, rst, sel, mem_rf, step, succ,  inc, dec, an, seg, led);
    
    initial begin
        inc = 1'b0;
        mem_rf = 1'b0;
        dec = 1'b0;
        sel = 3'b000;
        rst = 1'b1;
        succ = 1'b0;
        step = 1'b0;
        clk = 1'b0; #5 
        rst = 1'b0; #5
        
        
        // �ȼ������
        mem_rf = 1'b1;
        repeat(8) begin
            inc = 1'b1; clk = ~clk; #5; clk = ~clk; #5;
            inc = 1'b0; clk = ~clk; #5; clk = ~clk; #5;
        end
        inc = 1'b0;
        
        // _start:
        succ = 1'b1;
        repeat(7) begin
            clk = ~clk; #5; clk = ~clk; #5;
        end
        succ = 1'b0;
        
        // ���$t0(0x08), $t1, $t2, $t3(0x11), $s0(0x10), $s1(0x11)
        mem_rf = 1'b1;
        repeat(8) begin
            inc = 1'b1; clk = ~clk; #5; clk = ~clk; #5;
            inc = 1'b0; clk = ~clk; #5; clk = ~clk; #5;
        end
        inc = 1'b0;
        
        // _next1:
        succ = 1'b0;
        repeat(5) begin
            step = 1'b1; clk = ~clk; #5; clk = ~clk; #5; 
            step = 1'b0; clk = ~clk; #5; clk = ~clk; #5; 
        end
        succ = 1'b0;
        
        // _next2:
        succ = 1'b1;
        repeat(2) begin
            clk = ~clk; #5; clk = ~clk; #5;
        end
        succ = 1'b0;
        
        // ������ܼ���
        // _success: 
        succ = 1'b1;
        repeat(4) begin
            clk = ~clk; #5; clk = ~clk; #5;
        end
        
        // ���0x8��ַ�Ƿ�Ϊ1
        mem_rf = 1'b1;
        repeat(14) begin
            dec = 1'b1; clk = ~clk; #5; clk = ~clk; #5;
            dec = 1'b0; clk = ~clk; #5; clk = ~clk; #5;
        end
        dec = 1'b0;
        
        clk = ~clk; #5; clk = ~clk; #5;
        
        $finish;
    end
endmodule