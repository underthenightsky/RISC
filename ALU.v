`include "MUX.v"
module ALU (
    input [31:0] A, input [31:0] B, input [2:0] ALUControl, output [31:0] Result ,output Z,output N,output V,output C
);
    // declaring wires to hold the results
 wire [31:0] a_and_b;
 wire [31:0] a_or_b;
// Note 1: we cant choose which of these outputs gets calculated, calculate only one of them based on the need like in software, since we dont have that freedom in hardware modelling , all outputs need to be calculated and one of them gets chosen based on the opcode
// Logic Design 
    // Operations (Use Assign for wire value assignment)
//and operation
 assign a_and_b = A&B;
 // or operation
assign a_or_b= A|B;
 // not operation 
 wire [31:0]not_b;
 assign not_b=~B;
 // Mux 
 wire [31:0] mux_1;
MUX MUX_1(B,not_b,ALUControl[0],mux_1);

// wire sum 
wire [31:0] sum ;
wire cout; // to store carry
assign {cout,sum} = A+mux_1+ALUControl[0];

// Zero Extension 
assign slt = {{31{1'b0}},sum[31]};

// 4:1 Mux 
wire [31:0] mux_2 ;

assign mux_2 = (ALUControl[1:0]==2'b00) ? sum:
                (ALUControl[1:0]==2'b01) ? sum:
                (ALUControl[1:0]==2'b10) ? a_and_b:
                 (ALUControl[1:0]==2'b11) ?  a_or_b:
                (ALUControl[2:0]==3'b101) ?  slt :
                //if any outside of these specified 5 opcodes is recieved then output 0
                {32{1'b0}}    ;
                 
assign Result = mux_2;

// Flags 
wire Z,N,V,C;

// Zero Flag
assign Z = &(~ mux_2)

// Carry Flag 
assign c = cout & (~ALUControl[1]);

// Negative Flag
assign N = Result[31];

// Overflow Flag
assign O=(~(A[31]^B[31]^ALUControl[0])) & (A[31]^sum[31]) &(~ALUControl[1]);

endmodule