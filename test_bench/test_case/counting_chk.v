task run_test;
reg [31:0] task_rdata;

begin
$display("-------------------------------------------");
$display("===  TEST: CHECK  CONTROL MODE      ===");
$display("===========================================");
$display("----------      MODE 0        -----------");
$display("----------      CONT_EN       -----------");
test_bench.reg_wr( ADDR_THCSR,32'h0000_0001);
test_bench.reg_wr( ADDR_TCR,32'h0000_0003);
repeat(20)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_0015);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0002);
#100;
$display("----------      MODE OTHER    -----------");
$display("----------      CONT_EN_1     -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0103);
repeat(40)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_014);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0102);
#100;
$display("----------      CONT_EN_2     -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0203);
repeat(40)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_000a);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0202);
#100;
$display("----------      CONT_EN_3     -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0303);
repeat(80)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_000a);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0302);
#100;
$display("----------      CONT_EN_4     -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0403);
repeat(160)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_000a);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0402);
#100;
$display("----------      CONT_EN_5     -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0503);
repeat(320)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_000a);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0502);
#100;
$display("----------      CONT_EN_6     -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0603);
repeat(640)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_000a);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0602);
#100;
$display("----------      CONT_EN_7     -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0703);
repeat(1280)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_000a);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0702);
#100;
$display("----------      CONT_EN_8     -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0803);
repeat(2560)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_000a);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0802);
#100;
test_bench.reg_wr( ADDR_TCR,32'h0000_0000);
$display("----------      DF_MODE       -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0001);
repeat(20)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_0015);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0000);
#100;
$display("----------      DF_MODE       -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0101);
repeat(20)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_0015);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0100);
#100;
$display("----------      DF_MODE       -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0201);
repeat(20)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'h0000_0015);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0200);
#100;
$display("----------      DF_MODE       -----------");
test_bench.reg_wr( ADDR_TCR,32'h0000_0301);
repeat(61439)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'hf000_f000);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0300);
#100;
test_bench.reg_wr(ADDR_TDR0,32'hFFFF_FF00);
test_bench.reg_wr(ADDR_TDR1,32'hFFFF_FFFF);
test_bench.reg_wr( ADDR_TCR,32'h0000_0301);
repeat(254)begin
@(posedge sys_clk);
end
#1;
dbg_mode = 1;
test_bench.reg_rd( ADDR_TDR0 ,task_rdata);
test_bench.cmp_data( ADDR_TDR0,task_rdata,32'hFFFF_FFFF);
test_bench.reg_rd( ADDR_TDR1 ,task_rdata);
test_bench.cmp_data( ADDR_TDR1,task_rdata,32'hFFFF_FFFF);
@(posedge sys_clk);
dbg_mode = 0;
@(posedge sys_clk);
test_bench.reg_wr( ADDR_TCR,32'h0000_0300);
#100;

end
endtask