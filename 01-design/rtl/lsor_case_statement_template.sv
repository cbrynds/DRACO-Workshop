module lsor_case_statement (
    input logic [%N-1:0] x,
    output logic[%N-1:0] x_no_lso
);

    always_comb begin
        casez(x)
%CASES
        endcase
    end

endmodule