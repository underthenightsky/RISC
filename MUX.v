module MUX (
    input [31:0] A, input [31:0] B, input S, output [31:0] Result
);
    wire [31:0] output;
    // cant use if else outside of procedural block
    assign output = (S==1'b0)? A :B;
    assign Result =output;
endmodule