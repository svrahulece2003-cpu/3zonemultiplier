`timescale 1ns/1ps

module tb_three_zone_multiplier;

    reg  [15:0] A, B;
    wire [31:0] P;

    // Instantiate DUT
    three_zone_16bit_multiplier dut (
        .A(A),
        .B(B),
        .P(P)
    );

    initial begin
        // Monitor signals
        $monitor("Time=%0t | A=%d | B=%d | P=%d", $time, A, B, P);

        // Test cases
        A = 16'd0;   B = 16'd0;   #10;
        A = 16'd25;  B = 16'd12;  #10;
        A = 16'd100; B = 16'd200; #10;
        A = 16'd255; B = 16'd255; #10;
        A = 16'd1024;B = 16'd512; #10;
        A = 16'd32767; B = 16'd12345; #10;

        // End simulation
        $stop;
    end

endmodule
