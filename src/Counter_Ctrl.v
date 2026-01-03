module cnt_ctrl (
    input          clk,
    input          rst_n,
    input          timer_en,
    input          div_en,
    input  [3:0]   div_val,
    input          halt_req,
    input          debug_mode,
    output         cnt_en
);

reg [7:0] limit;

always @(*) begin
    case(div_val)
        4'b0000 : limit = 8'd0;    // chia 2
        4'b0001 : limit = 8'd1;    // chia 4
        4'b0010 : limit = 8'd3;    // chia 8
        4'b0011 : limit = 8'd7;    // chia 16
        4'b0100 : limit = 8'd15;   // chia 32
        4'b0101 : limit = 8'd31;   // chia 64
        4'b0110 : limit = 8'd63;   // chia 128
        4'b0111 : limit = 8'd127;  // chia 256
        4'b1000 : limit = 8'd255;
        default : limit = limit;
    endcase
end

wire gan_tmp;
wire cnt_rst;
wire [7:0] int_cnt_tmp;
wire halt_ack;

assign halt_ack = halt_req | debug_mode;
reg [7:0] int_cnt_r;

assign gan_tmp = (limit == int_cnt_r) & (timer_en | div_en) & !halt_ack;

assign cnt_rst = !div_en | !timer_en | halt_ack ? 8'b0 : gan_tmp;

assign int_cnt_tmp = cnt_rst & halt_ack ?
                     (timer_en & (div_val != 0) & !halt_ack) ? int_cnt_r + 1
                   : int_cnt_r
                   : int_cnt_r;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        int_cnt_r <= 8'b0;
    end
    else begin
        int_cnt_r <= int_cnt_tmp;
    end
end

// cnt_en
// default mode
wire df_mode;
assign df_mode = !div_en & timer_en & !halt_ack;

// control mode
wire ctrl0_mode;
assign ctrl0_mode = (div_val == 0) & div_en & timer_en & !halt_ack;

// other_control
wire other_ctrl;
assign other_ctrl = (div_val != 0) & div_en & timer_en & gan_tmp & !halt_ack;

assign cnt_en = df_mode | ctrl0_mode | other_ctrl;

endmodule