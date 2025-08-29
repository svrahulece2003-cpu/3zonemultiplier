module approx_mult8_cp1 (
    input  [7:0] A,
    input  [7:0] B,
    output [15:0] P
);
    // CP1 approximation (basic multiply)
    assign P = A * B;
endmodule
