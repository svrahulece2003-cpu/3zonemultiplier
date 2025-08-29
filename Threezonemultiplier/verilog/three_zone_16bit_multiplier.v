module three_zone_16bit_multiplier (
    input  [15:0] A,
    input  [15:0] B,
    output [31:0] P
);

    wire [7:0]  LSB_A, LSB_B;
    wire [7:0]  MID_A, MID_B;
    wire [15:0] MSB_A, MSB_B;

    wire [15:0] P_lsb, P_mid;
    wire [31:0] P_msb;

    // Zone partition
    assign LSB_A = A[7:0];
    assign LSB_B = B[7:0];
    assign MID_A = A[15:8];
    assign MID_B = B[15:8];
    assign MSB_A = A;
    assign MSB_B = B;

    // LSB Zone (CP3)
    approx_mult8_cp3 LSB_zone (
        .A(LSB_A),
        .B(LSB_B),
        .P(P_lsb)
    );

    // Middle Zone (CP1)
    approx_mult8_cp1 MID_zone (
        .A(MID_A),
        .B(MID_B),
        .P(P_mid)
    );

    // MSB Zone (Exact multiplication)
    assign P_msb = MSB_A * MSB_B;

    // Final product combining all zones
    assign P = {P_msb[31:16], P_mid, P_lsb};

endmodule
