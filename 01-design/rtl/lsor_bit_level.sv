module lsor_bit_level #(parameter N=4) (
    input logic [N-1:0] x,
    output logic [N-1:0] x_no_lso
);

logic [N-1:0] d;
assign d[0] = x[0];

genvar i;
generate
    for (i = 1; i < N-1; i++) begin
        assign d[i] = x[i] | d[i-1];
    end
endgenerate

assign x_no_lso[0] = 1'b0;
assign x_no_lso[N-1:1] = x[N-1:1] & d[N-2:0];

endmodule