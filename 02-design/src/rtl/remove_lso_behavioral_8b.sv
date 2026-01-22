module remove_lso_behavioral_8b (
    input logic [8-1:0] x,
    output logic[8-1:0] x_no_lso
);

    always_comb begin
        casez(x)
			8'b???????1: x_no_lso = {x[7:1],1'b0};
			8'b??????10: x_no_lso = {x[7:2],2'b0};
			8'b?????100: x_no_lso = {x[7:3],3'b0};
			8'b????1000: x_no_lso = {x[7:4],4'b0};
			8'b???10000: x_no_lso = {x[7:5],5'b0};
			8'b??100000: x_no_lso = {x[7:6],6'b0};
			8'b?1000000: x_no_lso = {x[7:7],7'b0};
			8'b?0000000: x_no_lso = 8'b0;

        endcase
    end

endmodule