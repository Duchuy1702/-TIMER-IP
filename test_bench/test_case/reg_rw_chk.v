task run_test();
    reg[31:0] task_rdata;

    begin
        $display("========================================");
        $display("====  TEST: CHECK  REGISTER_RW  ========");
        $display("========================================");

        // ---------------- CHECK TCMP0 -------------------
        $display("--------- CHECK TCMP0-----------------");
        test_bench.reg_wr( ADDR_TCMP0, 32'h0);
        test_bench.reg_rd( ADDR_TCMP0, task_rdata);
        test_bench.cmp_data( ADDR_TCMP0, task_rdata, 32'h0);

        test_bench.reg_wr( ADDR_TCMP0, 32'hffff_ffff);
        test_bench.reg_rd( ADDR_TCMP0, task_rdata);
        test_bench.cmp_data( ADDR_TCMP0, task_rdata, 32'hffff_ffff);

        test_bench.reg_wr( ADDR_TCMP0, 32'h0000_5678);
        test_bench.reg_rd( ADDR_TCMP0, task_rdata);
        test_bench.cmp_data( ADDR_TCMP0, task_rdata, 32'h0000_5678);

        test_bench.reg_wr( ADDR_TCMP0, 32'hdddd_0000);
        test_bench.reg_rd( ADDR_TCMP0, task_rdata);
        test_bench.cmp_data( ADDR_TCMP0, task_rdata, 32'hdddd_0000);

        // ---------------- CHECK TCMP1 -------------------
        $display("--------- CHECK TCMP1-----------------");
        test_bench.reg_wr( ADDR_TCMP1, 32'h0);
        test_bench.reg_rd( ADDR_TCMP1, task_rdata);
        test_bench.cmp_data( ADDR_TCMP1, task_rdata, 32'h0);

        test_bench.reg_wr( ADDR_TCMP1, 32'hffff_ffff);
        test_bench.reg_rd( ADDR_TCMP1, task_rdata);
        test_bench.cmp_data( ADDR_TCMP1, task_rdata, 32'hffff_ffff);

        test_bench.reg_wr( ADDR_TCMP1, 32'h1234_0000);
        test_bench.reg_rd( ADDR_TCMP1, task_rdata);
        test_bench.cmp_data( ADDR_TCMP1, task_rdata, 32'h1234_0000);

        test_bench.reg_wr( ADDR_TCMP1, 32'h0000_dddd);
        test_bench.reg_rd( ADDR_TCMP1, task_rdata);
        test_bench.cmp_data( ADDR_TCMP1, task_rdata, 32'h0000_dddd);

        // ---------------- CHECK TDR0 -------------------
        $display("--------- CHECK TDR0-----------------");
        test_bench.reg_wr( ADDR_TDR0, 32'h0);
        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h0);

        test_bench.reg_wr( ADDR_TDR0, 32'hffff_ffff);
        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'hffff_ffff);

        test_bench.reg_wr( ADDR_TDR0, 32'h1234_5678);
        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h1234_5678);

        test_bench.reg_wr( ADDR_TDR0, 32'h0);
        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h0);

        // ---------------- CHECK TDR1 -------------------
        $display("--------- CHECK TDR1-----------------");
        test_bench.reg_wr( ADDR_TDR1, 32'h0);
        test_bench.reg_rd( ADDR_TDR1, task_rdata);
        test_bench.cmp_data( ADDR_TDR1, task_rdata, 32'h0);

        test_bench.reg_wr( ADDR_TDR1, 32'hffff_ffff);
        test_bench.reg_rd( ADDR_TDR1, task_rdata);
        test_bench.cmp_data( ADDR_TDR1, task_rdata, 32'hffff_ffff);

        test_bench.reg_wr( ADDR_TDR1, 32'h1234_5678);
        test_bench.reg_rd( ADDR_TDR1, task_rdata);
        test_bench.cmp_data( ADDR_TDR1, task_rdata, 32'h1234_5678);

        test_bench.reg_wr( ADDR_TDR1, 32'h0);
        test_bench.reg_rd( ADDR_TDR1, task_rdata);
        test_bench.cmp_data( ADDR_TDR1, task_rdata, 32'h0);

        // ---------------- CHECK TCR -------------------
        $display("--------- CHECK TCR-----------------");
        test_bench.reg_wr( ADDR_TCR, 32'h0);
        test_bench.reg_rd( ADDR_TCR, task_rdata);
        test_bench.cmp_data( ADDR_TCR, task_rdata, 32'h0);

        test_bench.reg_wr( ADDR_TCR, 32'hffff_ffff);
        test_bench.reg_rd( ADDR_TCR, task_rdata);
        test_bench.cmp_data( ADDR_TCR, task_rdata, 32'h0);

        test_bench.reg_wr( ADDR_TCR, 32'h1234_5678);
        test_bench.reg_rd( ADDR_TCR, task_rdata);
        test_bench.cmp_data( ADDR_TCR, task_rdata, 32'h0000_0600);

        test_bench.reg_wr( ADDR_TCR, 32'h0);
        test_bench.reg_rd( ADDR_TCR, task_rdata);
        test_bench.cmp_data( ADDR_TCR, task_rdata, 32'h0);

        // ---------------- CHECK TIER -------------------
        $display("--------- CHECK TIER-----------------");
        test_bench.reg_wr( ADDR_TIER, 32'h0);
        test_bench.reg_rd( ADDR_TIER, task_rdata);
        test_bench.cmp_data( ADDR_TIER, task_rdata, 32'h0);

        test_bench.reg_wr( ADDR_TIER, 32'hffff_ffff);
        test_bench.reg_rd( ADDR_TIER, task_rdata);
        test_bench.cmp_data( ADDR_TIER, task_rdata, 32'h0000_0001);

        test_bench.reg_wr( ADDR_TIER, 32'h1234_5678);
        test_bench.reg_rd( ADDR_TIER, task_rdata);
        test_bench.cmp_data( ADDR_TIER, task_rdata, 32'h0000_0000);

        test_bench.reg_wr( ADDR_TIER, 32'heeee_eeef);
        test_bench.reg_rd( ADDR_TIER, task_rdata);
        test_bench.cmp_data( ADDR_TIER, task_rdata, 32'h0000_0001);

        // ---------------- CHECK TISR -------------------
        $display("--------- CHECK TISR-----------------");
        test_bench.reg_wr( ADDR_TISR, 32'hffff_ffff);
        test_bench.reg_rd( ADDR_TISR, task_rdata);
        test_bench.cmp_data( ADDR_TISR, task_rdata, 32'h0);

        test_bench.reg_wr( ADDR_TISR, 32'h0000_0000);
        test_bench.reg_rd( ADDR_TISR, task_rdata);
        test_bench.cmp_data( ADDR_TISR, task_rdata, 32'h0);

        // ---------------- CHECK THCSR --------------------
        $display("--------- CHECK THCSR-----------------");
        test_bench.reg_wr( ADDR_THCSR, 32'h0);
        test_bench.reg_rd( ADDR_THCSR, task_rdata);
        test_bench.cmp_data( ADDR_THCSR, task_rdata, 32'h0);

        test_bench.reg_wr( ADDR_THCSR, 32'hffff_ffff);
        test_bench.reg_rd( ADDR_THCSR, task_rdata);
        test_bench.cmp_data( ADDR_THCSR, task_rdata, 32'h0000_0001);

        test_bench.reg_wr( ADDR_THCSR, 32'hffff_0000);
        test_bench.reg_rd( ADDR_THCSR, task_rdata);
        test_bench.cmp_data( ADDR_THCSR, task_rdata, 32'h0);

        // ---------------- CHECK INVALID ADDRESS -------------
        $display("--------- CHECK != ADDR_REGISTER---------");

        test_bench.reg_wr( 12'hfff, 32'hffff_ffff);
        test_bench.reg_rd( 12'hfff, task_rdata);
        test_bench.cmp_data( 12'hfff, task_rdata, 32'h0);

        test_bench.reg_wr( 12'h001, 32'hffff_ffff);
        test_bench.reg_rd( 12'h001, task_rdata);
        test_bench.cmp_data( 12'h001, task_rdata, 32'h0);

    end
endtask