task run_test();
    reg[31:0] task_rdata;

    begin
        $display("========================================");
        $display("====------ TEST: APB Protocol----------====");
        $display("========================================");

        test_bench.reg_wr(ADDR_TDR0, 32'h8888_8888);
        test_bench.reg_rd(ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h8888_8888);

        $display("penable does not assert");
        test_bench.apb_err_penable = 1;
        test_bench.reg_wr(ADDR_TDR0, 32'haaaa_aaaa);
        test_bench.apb_err_penable = 0;

        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h8888_8888);

        test_bench.apb_err_penable = 1;
        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h0);
        test_bench.apb_err_penable = 0;

        $display("psel does not assert");
        test_bench.apb_err_psel = 1;
        test_bench.reg_wr(ADDR_TDR0, 32'h2222_2222);
        test_bench.apb_err_psel = 0;

        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h8888_8888);

        test_bench.apb_err_psel = 1;
        test_bench.reg_rd( ADDR_TDR0, task_rdata);
        test_bench.cmp_data( ADDR_TDR0, task_rdata, 32'h0);
        test_bench.apb_err_penable = 0;

    end
endtask