`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/29 16:34:33
// Design Name: 
// Module Name: cpu_pipeline
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


module cpu_pipeline
(
input clk,  // ʱ��, ��������Ч
input rst,   // �첽��λ, �ߵ�ƽ��Ч
input [31:0] dbu_mem_rf_addr,   // DBUѡ���ַ
output [31:0] dbu_rf_data,      // DBUѡ���ַ�ļĴ���������
output [31:0] dbu_mem_data,     // DBUѡ���ַ�Ĵ洢������
output [31:0] dbu_pc,           // PC
output [31:0] dbu_ir,           // IR
output [31:0] dbu_md,           // MD, �洢���ж������ݼĴ���
output [31:0] dbu_a,            // A
output [31:0] dbu_b,            // B
output [31:0] dbu_alu_out,      // ALUOut
output [15:0] dbu_status
);



endmodule
