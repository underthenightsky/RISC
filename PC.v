module Program_Counter (
    PC_NEXT,PC,rst,clk
);
    input [31:0] PC_NEXT;
    input clk,rst;
    output reg [31:0] PC;
    always @(posedge clk) begin
        if (rst == 1'b0) begin
            PC <= {32{1'b0}};
        end
        else begin
          PC <= PC_NEXT;
        end
    end
endmodule