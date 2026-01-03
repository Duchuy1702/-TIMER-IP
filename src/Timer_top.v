module timer_top(
input        sys_clk    ,
input        sys_rst_n  ,
input        tim_psel   ,
input        tim_pwrite ,
input        tim_penable,
input [11:0] tim_paddr  ,
input [31:0] tim_pwdata ,
input [3:0]  tim_pstrb  ,
input        dbg_mode   ,
output       tim_int    ,
output [31:0] tim_prdata,
output       tim_pready ,
output       tim_pslverr
);

wire [63:0] cnt_tmp     ;
wire        tdr0_tmp    ;
wire        tdr1_tmp    ;
wire        timer_en_tmp;
wire        wr_en_tmp   ;
wire        rd_en_tmp   ;
wire        div_en_tmp  ;
wire [3:0]  div_val_tmp ;
wire        halt_req_tmp;
wire        cnt_en_tmp  ;
wire        pslverr     ;
wire [31:0] mem_tdr0    ;
wire [31:0] mem_tdr1    ;
wire        rst_cnt     ;

apb_slave dul (
    .clk     (sys_clk)    ,
    .rst_n   (sys_rst_n)  ,
    .psel    (tim_psel)   ,
    .pwrite  (tim_pwrite) ,
    .penable (tim_penable),
    .pready  (tim_pready ),
    .wr_en   (wr_en_tmp)  ,
    .rd_en   (rd_en_tmp)
);

register du2 (
    .clk        (sys_clk)      ,
    .rst_n      (sys_rst_n)    ,
    .wr_en      (wr_en_tmp)    ,
    .rd_en      (rd_en_tmp)    ,
    .addr       (tim_paddr)    ,
    .wdata      (tim_pwdata)   ,
    .pstrb      (tim_pstrb)    ,
    .rdata      (tim_prdata)   ,
    .div_en     (div_en_tmp)   ,
    .div_val    (div_val_tmp)  ,
    .halt_req   (halt_req_tmp) ,
    .timer_en   (timer_en_tmp) ,
    .interrupt  (tim_int)      ,
    .dbg_mode   (dbg_mode)     ,
    .tdr0_wr    (tdr0_tmp)     ,
    .tdr1_wr    (tdr1_tmp)     ,
    .count      (cnt_tmp)      ,
    .mem_tdr0   (mem_tdr0)     ,
    .mem_tdr1   (mem_tdr1)     ,
    .rst_cnt    (rst_cnt)      ,
    .er_div     (pslverr)
);

cnt_ctrl du3 (
    .clk        (sys_clk)    ,
    .rst_n      (sys_rst_n)  ,
    .timer_en  (timer_en_tmp),
    .div_en    (div_en_tmp)  ,
    .div_val   (div_val_tmp) ,
    .halt_req  (halt_req_tmp),
    .debug_mode(dbg_mode)    ,
    .cnt_en    (cnt_en_tmp)
);

counter du4 (
    .clk         (sys_clk)   ,
    .rst_n       (sys_rst_n) ,
    .cnt_en      (cnt_en_tmp),
    .rst_cnt     (rst_cnt)   ,
    .mem_tdr0    (mem_tdr0)  ,
    .mem_tdr1    (mem_tdr1)  ,
    .tdr0_wr_sel (tdr0_tmp)  ,
    .tdr1_wr_sel (tdr1_tmp)  ,
    .cnt         (cnt_tmp)
);

assign tim_pslverr = (!sys_rst_n) ? 1'b0 : pslverr ;

endmodule