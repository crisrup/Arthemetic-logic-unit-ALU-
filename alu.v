module alu(
    input  [7:0] A, B,                  // ALU 8-bit Inputs
    input  [3:0] ALU_Sel,               // ALU Selection
    output [7:0] ALU_Out,               // ALU 8-bit Output
    output       CarryOut                // Carry Out Flag (valid for addition)
);
    reg [7:0] ALU_Result;
    wire [8:0] tmp;
    assign ALU_Out = ALU_Result;
    assign tmp = {1'b0, A} + {1'b0, B};
    assign CarryOut = tmp[8];           // Carryout flag for addition

    always @(*) begin
        case (ALU_Sel)
            4'b0000: ALU_Result = A + B;                           // Addition
            4'b0001: ALU_Result = A - B;                           // Subtraction
            4'b0010: ALU_Result = A * B;                           // Multiplication
            4'b0011: ALU_Result = (B != 0) ? (A / B) : 8'hFF;      // Division, FF if div by zero
            4'b0100: ALU_Result = A << 1;                          // Logical shift left
            4'b0101: ALU_Result = A >> 1;                          // Logical shift right
            4'b0110: ALU_Result = {A[6:0], A[7]};                  // Rotate left
            4'b0111: ALU_Result = {A[0], A[7:1]};                  // Rotate right
            4'b1000: ALU_Result = A & B;                           // Logical AND
            4'b1001: ALU_Result = A | B;                           // Logical OR
            4'b1010: ALU_Result = A ^ B;                           // Logical XOR
            4'b1011: ALU_Result = ~(A | B);                        // Logical NOR
            4'b1100: ALU_Result = ~(A & B);                        // Logical NAND
            4'b1101: ALU_Result = ~(A ^ B);                        // Logical XNOR
            4'b1110: ALU_Result = (A > B) ? 8'd1 : 8'd0;           // Greater comparison
            4'b1111: ALU_Result = (A == B) ? 8'd1 : 8'd0;          // Equal comparison
            default: ALU_Result = 8'd0;
        endcase
    end

endmodule