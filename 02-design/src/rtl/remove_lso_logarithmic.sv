module remove_lso_logarithmic #(parameter N=16) (
    input logic [N-1:0] x,
    output logic [N-1:0] x_no_lso
);

localparam NUM_LEVELS = $clog2(N)+1;
logic[NUM_LEVELS-1:0][N-1:0] PP_OR;
logic [N-1:0] d;

assign PP_OR[0] = x;

genvar level, bit_idx;

generate
    for (level = 1; level < NUM_LEVELS; level++) begin
        localparam INTERVAL =  1 << (level-1);
        localparam DOUBLE_INTERVAL =  1 << level;

        for (bit_idx = 0; bit_idx < N; bit_idx++) begin
            localparam GROUP_START = (bit_idx / DOUBLE_INTERVAL) * DOUBLE_INTERVAL;
            localparam GROUP_OFFSET = bit_idx - GROUP_START;
            localparam PARENT_IDX = GROUP_START + INTERVAL - 1;

            if (GROUP_OFFSET < INTERVAL) begin
                assign PP_OR[level][bit_idx] = PP_OR[level-1][bit_idx];
            end else begin
                assign PP_OR[level][bit_idx] = PP_OR[level-1][bit_idx] | PP_OR[level-1][PARENT_IDX];
            end
        end
    end
endgenerate

// assign x_no_lso = {x[N-1:1] & d[N-2:0],1'b0};
assign x_no_lso[0] = 1'b0;
assign x_no_lso[N-1:1] = x[N-1:1] & PP_OR[NUM_LEVELS-1][N-2:0];

endmodule