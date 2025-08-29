module approx_mult8_cp3 (
    input  [7:0] A,
    input  [7:0] B,
    output [15:0] P
);
    // CP3 approximation: simplified by truncating lower bits
    assign P = {4'b0, (A & B), 4'b0};
endmodule
