module behavioral #(parameter N=64) (
    input logic [N-1:0] x,
    output logic [N-1:0] x_no_lso
);

    logic found;

    always_comb begin
        
        x_no_lso = x;
        found = 1'b0;

        for (int i = 0; i < N; i++) begin
            if (!found && x[i]) begin
                x_no_lso[i] = 1'b0;
                found = 1'b1;
            end
        end

    end

endmodule