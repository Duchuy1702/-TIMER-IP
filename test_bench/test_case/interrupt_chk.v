task run_test();

    begin
        $display("========================================");
        $display("====   TEST: CHECK  Interrupt  =========");
        $display("========================================");

        $display("=========== Write TCMP0 ================");
        $display("----------- Write tcmp0 = 255 ----------");
        test_bench.reg_wr(ADDR_TCMP0, 32'h0000_00FF);

        $display("=========== Write TCMP1 ================");
        $display("----------- Write tcmp1 = 000 ----------");
        test_bench.reg_wr(ADDR_TCMP1, 32'h0000_0000);

        $display("=========== Write TIER =================");
        $display("----------- Write tier = 32'h0000_0001  ");
        test_bench.reg_wr(ADDR_TIER, 32'h0000_0001);

        $display("=========== Write TCR ==================");
        $display("----------- Write tcr = 32'h0000_0001 - ");
        test_bench.reg_wr(ADDR_TCR, 32'h0000_0001);

        repeat(260) begin
            @(posedge sys_clk);
        end

        dbg_mode = 1;
        $display("=========== TIMER STOP =================");
        $display("----------- Write thcsr = 32'h0000_0001 ");
        test_bench.reg_wr(ADDR_TCR, 32'h0000_0001);

        $display("=========== CHECK INTERRUPT ============");
        if ( interrupt == 1 ) begin
            $display("PASS: Interrupt = %h ", interrupt);
        end
        else begin
            $display("FAIL: Interrupt = %h", interrupt);
        end

        $display("============ CLEAR TIMER ================");
        $display("------------ Write TISR_PSTRB[0] = 0-----");

        test_bench.reg_wr_pstrb(ADDR_TISR, 32'h0000_0001, 4'h0);
        $display("------ Write data = 32'h0000_0001 at TIST--");
        $display("========= CHECK INTERRUPT ================");
        if ( interrupt == 1 ) begin
            $display("PASS: Interrupt = %h ", interrupt);
        end
        else begin
            $display("FAIL: Interrupt = %h", interrupt);
        end

        $display("--------- Write TISR_PSTRB[0] = 1---------");
        test_bench.reg_wr(ADDR_TISR, 32'h0000_0001);
        $display("------ Write data = 32'h0000_0001 at TIST--");
        $display("========= CHECK INTERRUPT ================");
        if ( interrupt == 0 ) begin
            $display("PASS: Interrupt = %h ", interrupt);
        end
        else begin
            $display("FAIL: Interrupt = %h", interrupt);
        end

    end
endtask