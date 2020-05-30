`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/30 12:06:37
// Design Name: 
// Module Name: control_unit
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


module control_unit
#(
parameter ADD_op = 6'b000000,
parameter ADDI_op = 6'b001000,
parameter LW_op = 6'b100011,
parameter SW_op = 6'b101011,
parameter BEQ_op = 6'b000100,
parameter J_op = 6'b000010,

parameter ALU_ADD = 3'b000,
parameter ALU_SUB = 3'b001,
parameter ALU_AND = 3'b010,
parameter ALU_OR = 3'b011,
parameter ALU_XOR = 3'b100
)
(
input [5:0] opcode,
output [1:0] WB,    // mem_to_reg, reg_write
output [1:0] M,     // mem_write, mem_read
output [3:0] EX,     // alu_src, alu_op, reg_dst
output reg [1:0] pc_src
);

reg reg_dst;
reg [1:0] alu_op;
reg alu_src;
reg mem_read;
reg mem_write;
reg reg_write;
reg mem_to_reg;

assign EX = {alu_src, reg_dst, alu_op};
assign M = {mem_write, mem_read};
assign WB = {mem_to_reg, reg_write};

always @(*) begin
    {reg_dst, alu_op, alu_src, mem_read, mem_write, reg_write, mem_to_reg, pc_src} = 10'h000;
    case(opcode)
        ADD_op: begin
            reg_dst = 1'b1;
            alu_op = 2'b10; // 按 funct
            reg_write = 1'b1;
        end
        ADDI_op: begin
            alu_op = 2'b00; // 做加法
            alu_src = 1'b1; // 选立即数
            reg_write = 1'b1;
        end
        LW_op: begin
            alu_op = 2'b00; // 做加法
            alu_src = 1'b1; // 选立即数
            mem_read = 1'b1;
            reg_write = 1'b1;
            mem_to_reg = 1'b1;
        end
        SW_op: begin
            alu_op = 2'b00; // 做加法
            alu_src = 1'b1; // 选立即数
            mem_write = 1'b1;
        end
        BEQ_op: begin
            pc_src = 2'b01;
            alu_src = 1'b1;
        end
        J_op: begin
            pc_src = 2'b10;
            alu_src = 1'b1;
        end
        default: {reg_dst, alu_op, alu_src, mem_read, mem_write, reg_write, mem_to_reg, pc_src} = 10'h000;
    endcase
end

endmodule
