module apb_slave (
    input          clk,
    input          rst_n,
    input          psel,
    input          pwrite,
    input          penable,
    output         wr_en,
    output         rd_en,
    output         pready
);

assign wr_en = psel & pwrite & penable;
assign rd_en = psel & !pwrite & penable;

reg pready_r;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        pready_r <= 0;
    end
    else begin
        pready_r <= penable;
    end
end

assign pready = penable & pready_r; // Pready deasserts (1->0) when the transfer is completed

endmodule