task run_test();
    begin

        $display("==== CHECK PSLVERR =====");

        $display("---Write data= 32'h0000_0001 at TCR ,count_en ");
        test_bench.reg_wr(ADDR_TCR, 32'h0000_0001);

        $display("---Write data= 32'h0000_0003 at TCR ,err_div_ev ");
        test_bench.reg_wr_pslverr(ADDR_TCR, 32'h0000_0003);

        $display("---Write data= 32'h0000_0111 at TCR ,err_div_ev and div_val ");
        test_bench.reg_wr_pslverr(ADDR_TCR, 32'h0000_0111);

        $display("---Write data= 32'h0000_0000 at TCR , timer = 0 ");
        test_bench.reg_wr(ADDR_TCR, 32'h0000_0000);

        $display("---Write data= 32'h0000_0911 at TCR ,err_div_val ");
        test_bench.reg_wr_pslverr(ADDR_TCR, 32'h0000_0911);

        $display("---Write data= 32'h0000_0411 at TCR , count_en , mode 4 ");
        test_bench.reg_wr(ADDR_TCR, 32'h0000_0411);

        $display("---Write data= 32'h0000_0501 at TCR ,err_div_ev and div_val ");
        test_bench.reg_wr_pslverr(ADDR_TCR, 32'h0000_0501);

        $display("---Write data= 32'h0000_0410 at TCR , timer = 0 ");
        test_bench.reg_wr(ADDR_TCR, 32'h0000_0410);

    end
endtask