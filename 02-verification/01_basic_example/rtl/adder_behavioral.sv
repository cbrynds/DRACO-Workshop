module adder_behavioral #(parameter N=64) (
    input logic [N-1:0] x,
    input logic [N-1:0] y,
    input logic cin,
    output logic [N:0] sum
);

assign sum = x + y + cin;

endmodule