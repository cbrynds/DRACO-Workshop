module lsor_word_level #(parameter N=16)(
    input logic[N-1:0] x,
    output logic[N-1:0] x_no_lso
);

assign x_no_lso = x & (x-1);

endmodule