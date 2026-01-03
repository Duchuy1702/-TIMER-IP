module test_bench;

reg          sys_clk     ;
reg          sys_rst_n   ;
reg          tim_psel    ;
reg          tim_pwrite  ;
reg          tim_penable ;
reg  [11:0]  tim_paddr   ;
reg  [31:0]  tim_pwdata  ;
reg  [3:0]   tim_pstrb   ;
reg          dbg_mode    ;
wire         interrupt   ;
wire [31:0]  tim_prdata  ;
wire         tim_pready  ;
wire         tim_pslverr ;


parameter ADDR_TCR   = 12'h00;
parameter ADDR_TDR0  = 12'h04;
parameter ADDR_TDR1  = 12'h08;
parameter ADDR_TCMP0 = 12'h0C;
parameter ADDR_TCMP1 = 12'h10;
parameter ADDR_TIER  = 12'h14;
parameter ADDR_TISR  = 12'h18;
parameter ADDR_THCSR = 12'h1C;

reg apb_err_psel;
reg apb_err_penable;


timer_top dut1 ( .sys_clk     (sys_clk     ),
                 .sys_rst_n   (sys_rst_n   ),
                 .tim_psel    (tim_psel    ),
                 .tim_pwrite  (tim_pwrite  ),
                 .tim_penable (tim_penable ),
                 .tim_paddr   (tim_paddr   ),
                 .tim_pwdata  (tim_pwdata  ),
                 .tim_pstrb   (tim_pstrb   ),
                 .dbg_mode    (dbg_mode    ),
                 .tim_int     (interrupt   ),
                 .tim_prdata  (tim_prdata  ),
                 .tim_pready  (tim_pready  ),
                 .tim_pslverr (tim_pslverr )

);

`include "run_test.v"

initial begin
    sys_clk = 0;
    forever #50 sys_clk = ~ sys_clk;
end

initial begin
    sys_rst_n = 1'b0;
    #50
    sys_rst_n = 1'b1;
end

initial begin
    #100;
    run_test();
    #100;
    $finish;
end

initial begin
    apb_err_psel = 0;
    apb_err_penable = 0;
    tim_paddr = 0;
    tim_pwdata = 0;
    tim_psel = 0;
    tim_penable = 0;
    tim_pwrite = 0;
    dbg_mode = 0;
    tim_pstrb = 4'hf;
    #100;
end

task reg_wr;
    input [11:0] addr;
    input [31:0] data;

    begin
        tim_pstrb = 4'hf;
        $display("----------------------------------------");
        $display(" WRITE : ADDR = %h , DATA = %h ",addr,data );
        $display("----------------------------------------");
        @(posedge sys_clk);
        #1;
        tim_psel = 1 & !apb_err_psel;
        tim_pwrite = 1;
        tim_paddr = addr;
        tim_pwdata = data;
        @(posedge sys_clk);
        #1;
        tim_penable = 1 & !apb_err_penable;
        if( apb_err_psel || apb_err_penable) begin
            //
        end
        else begin
            wait(tim_pready == 1);
        end
        @(posedge sys_clk);
        #1;
        tim_psel = 0;
        tim_pwrite = 0;
        tim_paddr = 0;
        tim_pwdata = 0;
        tim_penable = 0;
    end
endtask

task reg_rd;
    input [11:0] addr;
    output [31:0] rdata;

    begin
        $display("----------------------------------------");
        $display("--------- READ : ADDR = %h ---------",addr );
        $display("----------------------------------------");
        @(posedge sys_clk);
        #1;
        tim_psel = 1 & !apb_err_psel;
        tim_pwrite = 0;
        tim_paddr = addr;
        @(posedge sys_clk);
        #1;
        tim_penable = 1 & !apb_err_penable;
        if(apb_err_psel || apb_err_penable) begin
            //
        end
        else begin
            wait(tim_pready == 1);
        end
        #1;
        rdata = tim_prdata;
        @(posedge sys_clk);
        tim_psel = 0;
        tim_pwrite = 0;
        tim_paddr = 0;
        tim_pwdata = 0;
        tim_penable = 0;
    end
endtask

task cmp_data;
    input [11:0] addr;
    input [31:0] data;
    input [31:0] exp_data;

    if ( data == exp_data ) begin
        $display("----------------------------------------");
        $display(" PASS: rdata = %h at addr %h is correct- ", data,addr);
        $display("----------------------------------------");
    end
    else begin
        $display("----------------------------------------");
        $display(" FAIL: rdata = %h at addr %h is not correct- ", data,addr);
        $display("----------------------------------------");
    end
endtask

task reg_init_check;
    reg [31:0] task_rdata;
    begin
        reg_rd( ADDR_TCR, task_rdata);
        cmp_data( ADDR_TCR, task_rdata, 32'h0000_0100);

        reg_rd( ADDR_TDR0, task_rdata);
        cmp_data( ADDR_TDR0, task_rdata, 32'h0000_0000);

        reg_rd( ADDR_TDR1, task_rdata);
        cmp_data( ADDR_TDR1, task_rdata, 32'h0000_0000);

        reg_rd( ADDR_TCMP0, task_rdata);
        cmp_data( ADDR_TCMP0, task_rdata, 32'hFFFF_FFFF);

        reg_rd( ADDR_TCMP1, task_rdata);
        cmp_data( ADDR_TCMP1, task_rdata, 32'hFFFF_FFFF);

        reg_rd( ADDR_TIER, task_rdata);
        cmp_data( ADDR_TIER, task_rdata, 32'h0000_0000);

        reg_rd( ADDR_TISR, task_rdata);
        cmp_data( ADDR_TISR, task_rdata, 32'h0000_0000);

        reg_rd( ADDR_THCSR, task_rdata);
        cmp_data( ADDR_THCSR, task_rdata, 32'h0000_0000);
    end
endtask

task reg_wr_pstrb;
    input [11:0] addr;
    input [31:0] data;
    input [3:0] pstrb;

    begin
        tim_pstrb = pstrb;
        $display("------------------------------------------------------------");
        $display(" WRITE : ADDR = %h , DATA = %h , Pstrb = %h ",addr,data,pstrb );
        $display("------------------------------------------------------------");
        @(posedge sys_clk);
        #1;
        tim_psel = 1;
        tim_pwrite = 1;
        tim_paddr = addr;
        tim_pwdata = data;
        @(posedge sys_clk);
        #1;
        tim_penable = 1;
        wait(tim_pready == 1);
        @(posedge sys_clk);
        #1;
        tim_pstrb = 0;
        tim_psel = 0;
        tim_pwrite = 0;
        tim_paddr = 0;
        tim_pwdata = 0;
        tim_penable = 0;
    end
endtask

task reg_wr_pslverr;
    input [11:0] addr;
    input [31:0] data;

    begin
        tim_pstrb = 4'hf;
        $display("----------------------------------------");
        $display(" WRITE : ADDR = %h , DATA = %h ",addr,data );
        $display("----------------------------------------");
        @(posedge sys_clk);
        #1;
        tim_psel = 1;
        tim_pwrite = 1;
        tim_paddr = addr;
        tim_pwdata = data;
        @(posedge sys_clk);
        #1;
        tim_penable = 1;
        wait(tim_pready == 1);
        if(tim_pslverr == 1)
            $display("PASS: Pslverr = %b",tim_pslverr);
        else
            $display(" FAIL");
        @(posedge sys_clk);
        #1;
        tim_psel = 0;
        tim_pwrite = 0;
        tim_paddr = 0;
        tim_pwdata = 0;
        tim_penable = 0;
    end
endtask

endmodule