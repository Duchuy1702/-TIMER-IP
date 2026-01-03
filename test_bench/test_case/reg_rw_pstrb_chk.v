task run_test();
    reg[31:0] task_rdata;

    begin
        $display("========================================");
        $display("====  TEST: CHECK  RG_RW_PSTRB  ======");
        $display("========================================");

        // ---------------- CHECK TCMP0 -----------------------
        $display("--------- CHECK TCMP0-----------------");
        test_bench.reg_wr_pstrb( ADDR_TCMP0, 32'h5555_5555, 4'h1);
        test_bench.reg_rd( ADDR_TCMP0, task_rdata);
        test_bench.cmp_data( ADDR_TCMP0, task_rdata, 32'hffff_ff55);

        test_bench.reg_wr_pstrb( ADDR_TCMP0, 32'hffff_ffff, 4'h3);
        test_bench.reg_rd( ADDR_TCMP0, task_rdata);
        test_bench.cmp_data( ADDR_TCMP0, task_rdata, 32'hffff_ffff);

        test_bench.reg_wr_pstrb( ADDR_TCMP0, 32'h1234_5678, 4'h8);
        test_bench.reg_rd( ADDR_TCMP0, task_rdata);
        test_bench.cmp_data( ADDR_TCMP0, task_rdata, 32'h12ff_ffff);

        test_bench.reg_wr_pstrb( ADDR_TCMP0, 32'hdddd_dddd, 4'h4);
        test_bench.reg_rd( ADDR_TCMP0, task_rdata);
        test_bench.cmp_data( ADDR_TCMP0, task_rdata, 32'h12dd_ffff);

        // ---------------- CHECK TCMP1 -----------------------
        $display("--------- CHECK TCMP1-----------------");
        test_bench.reg_wr_pstrb( ADDR_TCMP1, 32'hffff_ffff, 4'h0);
        test_bench.reg_rd( ADDR_TCMP1, task_rdata);
        test_bench.cmp_data( ADDR_TCMP1, task_rdata, 32'hffff_ffff);

        test_bench.reg_wr_pstrb( ADDR_TCMP1, 32'hffff_ffff, 4'hf);
        test_bench.reg_rd( ADDR_TCMP1, task_rdata);
        test_bench.cmp_data( ADDR_TCMP1, task_rdata, 32'hffff_ffff);

        test_bench.reg_wr_pstrb( ADDR_TCMP1, 32'h1234_5678, 4'h0);
        test_bench.reg_rd( ADDR_TCMP1, task_rdata);
        test_bench.cmp_data( ADDR_TCMP1, task_rdata, 32'hffff_ffff);

        test_bench.reg_wr_pstrb( ADDR_TCMP1, 32'hdddd_dddd, 4'hf);
        test_bench.reg_rd( ADDR_TCMP1, task_rdata);
        test_bench.cmp_data( ADDR_TCMP1, task_rdata, 32'hdddd_dddd);

        // ---------------- CHECK TDR0 ------------------
        $display("--------- CHECK TDR0-----------------");
        test_bench.reg_wr_pstrb( ADDR_TDR0, 32'h0, 4'hf);
        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h0);

        test_bench.reg_wr_pstrb( ADDR_TDR0, 32'hffff_ffff, 4'h1);
        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h0000_00ff);

        test_bench.reg_wr_pstrb( ADDR_TDR0, 32'h1234_5678, 4'hf);
        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h1234_5678);

        test_bench.reg_wr_pstrb( ADDR_TDR0, 32'hdddd_dddd, 4'hf);
        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'hdddd_dddd);

        // ---------------- CHECK TDR1 -------------------
        $display("--------- CHECK TDR1-----------------");
        test_bench.reg_wr_pstrb( ADDR_TDR1, 32'h0, 4'h3);
        test_bench.reg_rd( ADDR_TDR1, task_rdata);
        test_bench.cmp_data( ADDR_TDR1, task_rdata, 32'h0);

        test_bench.reg_wr_pstrb( ADDR_TDR1, 32'hffff_ffff, 4'h3);
        test_bench.reg_rd( ADDR_TDR1, task_rdata);
        test_bench.cmp_data( ADDR_TDR1, task_rdata, 32'h0000_ffff);

        test_bench.reg_wr_pstrb( ADDR_TDR1, 32'h1234_5678, 4'h0);
        test_bench.reg_rd( ADDR_TDR1, task_rdata);
        test_bench.cmp_data( ADDR_TDR1, task_rdata, 32'h0000_ffff);

        test_bench.reg_wr_pstrb( ADDR_TDR1, 32'hdddd_dddd, 4'h0);
        test_bench.reg_rd( ADDR_TDR1, task_rdata);
        test_bench.cmp_data( ADDR_TDR1, task_rdata, 32'h0000_ffff);

        // ---------------- CHECK TCR -------------------
        $display("--------- CHECK TCR-----------------");
        test_bench.reg_wr_pstrb( ADDR_TCR, 32'h0, 4'h0);
        test_bench.reg_rd( ADDR_TCR, task_rdata);
        test_bench.cmp_data( ADDR_TCR, task_rdata, 32'h0000_0100);

        test_bench.reg_wr_pstrb( ADDR_TCR, 32'hffff_ffff, 4'h1);
        test_bench.reg_rd( ADDR_TCR, task_rdata);
        test_bench.cmp_data( ADDR_TCR, task_rdata, 32'h0000_0103);

        test_bench.reg_wr_pstrb( ADDR_TCR, 32'h1234_5678, 4'h2);
        test_bench.reg_rd( ADDR_TCR, task_rdata);
        test_bench.cmp_data( ADDR_TCR, task_rdata, 32'h0000_0103);

        test_bench.reg_wr_pstrb( ADDR_TCR, 32'heeee_eeee, 4'hf);
        test_bench.reg_rd( ADDR_TCR, task_rdata);
        test_bench.cmp_data( ADDR_TCR, task_rdata, 32'h0000_0103);

        // ---------------- CHECK TIER -------------------
        $display("--------- CHECK TIER-----------------");
        test_bench.reg_wr_pstrb( ADDR_TIER, 32'h0, 4'hf);
        test_bench.reg_rd( ADDR_TIER, task_rdata);
        test_bench.cmp_data( ADDR_TIER, task_rdata, 32'h0);

        test_bench.reg_wr_pstrb( ADDR_TIER, 32'hffff_ffff, 4'h8);
        test_bench.reg_rd( ADDR_TIER, task_rdata);
        test_bench.cmp_data( ADDR_TIER, task_rdata, 32'h0000_0000);

        test_bench.reg_wr_pstrb( ADDR_TIER, 32'h1234_5678, 4'h2); 
        test_bench.reg_rd( ADDR_TIER, task_rdata);
        test_bench.cmp_data( ADDR_TIER, task_rdata, 32'h0000_0000);

        test_bench.reg_wr_pstrb( ADDR_TIER, 32'heeee_eeef, 4'h1);
        test_bench.reg_rd( ADDR_TIER, task_rdata);
        test_bench.cmp_data( ADDR_TIER, task_rdata, 32'h0000_0001);

        // ---------------- CHECK TISR --------------------
        $display("--------- CHECK TISR-----------------");
        test_bench.reg_wr_pstrb( ADDR_TISR, 32'hffff_ffff, 4'h8);
        test_bench.reg_rd( ADDR_TISR, task_rdata);
        test_bench.cmp_data( ADDR_TISR, task_rdata, 32'h0);

        test_bench.reg_wr_pstrb( ADDR_TISR, 32'h0000_0000f, 4'h4);
        test_bench.reg_rd( ADDR_TISR, task_rdata);
        test_bench.cmp_data( ADDR_TISR, task_rdata, 32'h0);

        // ---------------- CHECK THCSR -------------------
        $display("--------- CHECK THCSR-----------------");
        test_bench.reg_wr_pstrb( ADDR_THCSR, 32'h0, 4'h4);
        test_bench.reg_rd( ADDR_THCSR, task_rdata);
        test_bench.cmp_data( ADDR_THCSR, task_rdata, 32'h0);

        test_bench.reg_wr_pstrb( ADDR_THCSR, 32'hffff_ffff, 4'h1);
        test_bench.reg_rd( ADDR_THCSR, task_rdata);
        test_bench.cmp_data( ADDR_THCSR, task_rdata, 32'h0000_0001);

    end
endtask