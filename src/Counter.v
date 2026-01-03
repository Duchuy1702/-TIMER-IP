module counter(
    input          clk,
    input          rst_n,
    input          cnt_en,
    input          rst_cnt,
    input  [31:0]  mem_tdr0,
    input  [31:0]  mem_tdr1,
    input          tdr0_wr_sel,
    input          tdr1_wr_sel,
    output [63:0]  cnt
);

parameter DEFAULT_CNT = 32'h0;

wire [63:0] cnt_plus_1;
reg  [63:0] cnt0_r;
wire [31:0] cnt0;
wire [31:0] cnt1;

// counter 0:31
assign cnt0 = rst_cnt     ? DEFAULT_CNT    :
              tdr0_wr_sel ? mem_tdr0       :
              cnt_en      ? cnt_plus_1[31:0] :
                            cnt0_r[31:0];

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        cnt0_r[31:0] <= DEFAULT_CNT;
    end
    else begin
        cnt0_r[31:0] <= cnt0;
    end
end

// counter 63:32
assign cnt1 = rst_cnt     ? DEFAULT_CNT    :
              tdr1_wr_sel ? mem_tdr1       :
              cnt_en      ? cnt_plus_1[63:32] :
                            cnt0_r[63:32];

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        cnt0_r[63:32] <= DEFAULT_CNT;
    end
    else begin
        cnt0_r[63:32] <= cnt1;
    end
end

assign cnt_plus_1 = cnt0_r + 1;
assign cnt = cnt0_r;

endmodule