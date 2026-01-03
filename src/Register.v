module register(
input        clk,
input        rst_n,
input        wr_en,
input        rd_en,
input [11:0] addr,
input [31:0] wdata,
input [3:0]  pstrb,
input [63:0] count,
input        dbg_mode,
output [31:0] rdata,
output       div_en,
output [3:0] div_val,
output       halt_req,
output       timer_en,
output       interrupt,
output       er_div,
output       tdr0_wr,
output       tdr1_wr,
output [31:0] mem_tdr0,
output [31:0] mem_tdr1,
output       rst_cnt
);

parameter TCR  = 12'h00;
parameter TDR0 = 12'h04;
parameter TDR1 = 12'h08;
parameter TCMP0 = 12'h0C;
parameter TCMP1 = 12'h10;
parameter TIER  = 12'h14;
parameter TISR  = 12'h18;
parameter THCSR = 12'h1C;

//ADDR REDISTER
reg [7:0] sel_reg;
always @(*) begin
    case(addr)
        TCR   : sel_reg = 8'b0000_0001;
        TDR0  : sel_reg = 8'b0000_0010;
        TDR1  : sel_reg = 8'b0000_0100;
        TCMP0 : sel_reg = 8'b0000_1000;
        TCMP1 : sel_reg = 8'b0001_0000;
        TIER  : sel_reg = 8'b0010_0000;
        TISR  : sel_reg = 8'b0100_0000;
        THCSR : sel_reg = 8'b1000_0000;
        default : sel_reg = 8'b0000_0000;
    endcase
end

// TCR ERROR
// Error when accessing div_en while timer_en =1
// Error when accessing div_val while timer_en =1
// Error when div_val > 8 while timer_en = 0
wire er_v1;
wire er_v2;
wire er_v3;
reg [31:0] tcr;

assign er_v1 = timer_en & wr_en & sel_reg[0] & (wdata[1] != tcr[1]) & pstrb[0];
assign er_v2 = timer_en & wr_en & sel_reg[0] & (wdata[11:8] != tcr[11:8]) & pstrb[1];
assign er_v3 = !timer_en & wr_en & sel_reg[0] & (wdata[11:8] > 8) & pstrb[1];
assign er_div = er_v1 | er_v2 | er_v3;

// TCR tmp
// timer en and div en
wire tcr0_wr;
assign tcr0_wr = wr_en & sel_reg[0] & !er_div;
assign tcr0_wr_pstrb = tcr0_wr & pstrb[0];
wire [1:0] mem_tcr0;
assign mem_tcr0 = tcr0_wr_pstrb ? wdata[1:0] : tcr[1:0];

assign tim_en = tcr[0];
assign div_en = tcr[1];

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        tcr[1:0] <= 2'b0;
    end
    else begin
        tcr[1:0] <= mem_tcr0;
    end
end

// div_val
wire tcr1_wr;
assign tcr1_wr = wr_en & sel_reg[0] & !er_div;
wire tcr1_wr_pstrb;
assign tcr1_wr_pstrb = tcr1_wr & pstrb[1];

wire [3:0] mem_tcr1;
assign mem_tcr1 = tcr1_wr_pstrb ? wdata[11:8] : tcr[11:8];

assign div_val = tcr[11:8];

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        tcr[11:8] <= 4'b0001;
    end
    else begin
        tcr[11:8] <= mem_tcr1;
    end
end

// REG TCR
parameter DEFAULT_TCR = 32'h0000_0100;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        tcr <= DEFAULT_TCR;
    end
    else begin
        tcr <= {20'h0, mem_tcr1, 6'h0, mem_tcr0};
    end
end

// TDR0
// sel_reg[1]
parameter DEFAULT_TDR0 = 32'h0;
reg [31:0] tdr0_r;
wire tdr0_pstrb0;
wire tdr0_pstrb1;
wire tdr0_pstrb2;
wire tdr0_pstrb3;

assign tdr0_pstrb0 = wr_en & sel_reg[1] & pstrb[0];
assign tdr0_pstrb1 = wr_en & sel_reg[1] & pstrb[1];
assign tdr0_pstrb2 = wr_en & sel_reg[1] & pstrb[2];
assign tdr0_pstrb3 = wr_en & sel_reg[1] & pstrb[3];

assign mem_tdr0[7:0] = tdr0_pstrb0 ? wdata[7:0] : tdr0_r[7:0];
assign mem_tdr0[15:8] = tdr0_pstrb1 ? wdata[15:8] : tdr0_r[15:8];
assign mem_tdr0[23:16] = tdr0_pstrb2 ? wdata[23:16] : tdr0_r[23:16];
assign mem_tdr0[31:24] = tdr0_pstrb3 ? wdata[31:24] : tdr0_r[31:24];


always @(posedge clk or negedge rst_n) begin

if (!rst_n) begin
tdr0_r <= DEFAULT_TDR0;
end
else begin
tdr0_r <= mem_tdr0;
end
end

//When timer H->L, DEFAULT_VALUE
//TDR0
wire tdr_default;
assign tdr_default = tcr0_wr & pstrb[0] & timer_en & !wdata[0];
wire rst_cnt = tdr_default;
wire tdr0_default;
assign tdr0_default = tdr_default ? DEFAULT_TDR0 : tdr0_r;

always @(posedge clk or negedge rst_n) begin

if (!rst_n) begin
tdr0_r <= DEFAULT_TDR0;
end
else begin
tdr0_r <= tdr0_default;
end
end

// TDR1
// sel_reg[2]
parameter DEFAULT_TDR1 = 32'h0;
reg [31:0] tdr1_r;
wire tdr1_pstrb0;
wire tdr1_pstrb1;
wire tdr1_pstrb2;
wire tdr1_pstrb3;

assign tdr1_pstrb0 = wr_en & sel_reg[2] & pstrb[0];
assign tdr1_pstrb1 = wr_en & sel_reg[2] & pstrb[1];
assign tdr1_pstrb2 = wr_en & sel_reg[2] & pstrb[2];
assign tdr1_pstrb3 = wr_en & sel_reg[2] & pstrb[3];

assign mem_tdr1[7:0] = tdr1_pstrb0 ? wdata[7:0] : tdr1_r[7:0];
assign mem_tdr1[15:8] = tdr1_pstrb1 ? wdata[15:8] : tdr1_r[15:8];
assign mem_tdr1[23:16] = tdr1_pstrb2 ? wdata[23:16] : tdr1_r[23:16];
assign mem_tdr1[31:24] = tdr1_pstrb3 ? wdata[31:24] : tdr1_r[31:24];

always @(posedge clk or negedge rst_n) begin

if (!rst_n) begin
tdr1_r <= DEFAULT_TDR1;
end
else begin
tdr1_r <= mem_tdr1;
end
end

//When timer H->L, DEFAULT_VALUE
//TDR1
wire tdr1_default;
assign tdr1_default = tdr_default ? DEFAULT_TDR1 : tdr1_r;

always @(posedge clk or negedge rst_n) begin

if (!rst_n) begin
tdr1_r <= DEFAULT_TDR1;
end
else begin
tdr1_r <= tdr1_default;
end
end

assign tdr0_wr = wr_en & sel_reg[1];
assign tdr1_wr = wr_en & sel_reg[2];

// TCMP0
// sel_reg[3]
//compare 32 bit low cnt
parameter DEFAULT_TCMP0 = 32'hffff_ffff;

reg [31:0] tcmp0_r;
wire tcmp0_pstrb0;
wire tcmp0_pstrb1;
wire tcmp0_pstrb2;
wire tcmp0_pstrb3;
assign tcmp0_pstrb0 = wr_en & sel_reg[3] & pstrb[0];
assign tcmp0_pstrb1 = wr_en & sel_reg[3] & pstrb[1];
assign tcmp0_pstrb2 = wr_en & sel_reg[3] & pstrb[2];
assign tcmp0_pstrb3 = wr_en & sel_reg[3] & pstrb[3];

wire [31:0] mem_tcmp0;
assign mem_tcmp0[7:0] = tcmp0_pstrb0 ? wdata[7:0] : tcmp0_r[7:0];
assign mem_tcmp0[15:8] = tcmp0_pstrb1 ? wdata[15:8] : tcmp0_r[15:8];
assign mem_tcmp0[23:16] = tcmp0_pstrb2 ? wdata[23:16] : tcmp0_r[23:16];
assign mem_tcmp0[31:24] = tcmp0_pstrb3 ? wdata[31:24] : tcmp0_r[31:24];

always @(posedge clk or negedge rst_n) begin

if (!rst_n) begin
tcmp0_r <= DEFAULT_TCMP0;
end
else begin
tcmp0_r <= mem_tcmp0;
end
end

// TCMP1
// sel_reg[4]
//compare 32 bit up cnt
parameter DEFAULT_TCMP1 = 32'hffff_ffff;
reg [31:0] tcmp1_r;
wire tcmp1_pstrb0;
wire tcmp1_pstrb1;
wire tcmp1_pstrb2;
wire tcmp1_pstrb3;
assign tcmp1_pstrb0 = wr_en & sel_reg[4] & pstrb[0];
assign tcmp1_pstrb1 = wr_en & sel_reg[4] & pstrb[1];
assign tcmp1_pstrb2 = wr_en & sel_reg[4] & pstrb[2];
assign tcmp1_pstrb3 = wr_en & sel_reg[4] & pstrb[3];

wire [31:0] mem_tcmp1;
assign mem_tcmp1[7:0] = tcmp1_pstrb0 ? wdata[7:0] : tcmp1_r[7:0];
assign mem_tcmp1[15:8] = tcmp1_pstrb1 ? wdata[15:8] : tcmp1_r[15:8];
assign mem_tcmp1[23:16] = tcmp1_pstrb2 ? wdata[23:16] : tcmp1_r[23:16];
assign mem_tcmp1[31:24] = tcmp1_pstrb3 ? wdata[31:24] : tcmp1_r[31:24];

always @(posedge clk or negedge rst_n) begin
    
if (!rst_n) begin
tcmp1_r <= DEFAULT_TCMP1;
end
else begin
tcmp1_r <= mem_tcmp1;
end
end

// Compare -> interrupt
wire interrupt1;
assign interrupt1 = (tcmp0_r == count[31:0]) && (tcmp1_r == count[63:32]);

// TISR
// sel_reg[6]
reg [31:0] tisr;
wire tisr_wr;
assign tisr_wr = wr_en & sel_reg[6];
wire clr_tisr;
wire int_st;
assign clr_tisr = tisr_wr & pstrb[0] & wdata[0] & int_st;
wire tisr_en;

assign tisr_en = interrupt1;
wire mem_tisr;
assign mem_tisr = clr_tisr ? 1'b0:
                  tisr_en ? 1'b1:
                            tisr[0];

always @(posedge clk or negedge rst_n) begin
    
if (!rst_n) begin
tisr <= 32'h0;
end
else begin
tisr <= {31'h0,mem_tisr};
end
end

assign int_st = tisr[0];

// TIER
// sel_reg[5]
wire int_en;
reg [31:0] tier;
wire tier_wr;
assign tier_wr = wr_en & sel_reg[5];
wire tier_strb;
assign tier_strb = tier_wr & pstrb[0];
wire tier_en;
assign tier_en = tier_strb ? wdata[0] : tier[0];

always @(posedge clk or negedge rst_n) begin
    
if (!rst_n) begin
tier <= 32'h0;
end
else begin
tier <= {31'h0,tier_en};
end
end

assign int_en = tier[0];

// Announce interrupt
assign interrupt = int_en ? int_st : 1'b0;

// THCSR
// sel_reg[7]
// halt_req
reg [31:0] thcsr;
assign halt_req = thcsr[0];
wire thcsr_wr;
assign thcsr_wr = wr_en & sel_reg[7];
wire thcsr_strb;
assign thcsr_strb = thcsr_wr & pstrb[0];
wire thcsr_en;
assign thcsr_en = thcsr_strb ? wdata[0] : thcsr[0];

// halt_ack
wire halt_ack;
assign halt_ack = halt_req & dbg_mode;

always @(posedge clk or negedge rst_n) begin
    
if (!rst_n) begin
thcsr <= 32'h0;
end
else begin
thcsr <= {30'h0,halt_ack,thcsr_en};
end
end

// READ
reg [31:0] rdata_r;

always @(*)begin
if(!rst_n) begin
rdata_r = 0;
end
else if(rd_en) begin
case(addr)
TCR : rdata_r = tcr ;
TDR0 : rdata_r = count[31:0] ;
TDR1 : rdata_r = count[63:32] ;
TCMP0 : rdata_r = tcmp0_r ;
TCMP1 : rdata_r = tcmp1_r ;
TIER : rdata_r = tier ;
TISR : rdata_r = tisr ;
THCSR : rdata_r = thcsr ;
default : rdata_r = 32'h0 ;
endcase
end
else begin
rdata_r = 32'h0;
end
end
assign rdata = rdata_r;

endmodule
