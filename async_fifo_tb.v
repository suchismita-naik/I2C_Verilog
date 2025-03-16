module async_fifo_tb;
    reg wr_clk, rd_clk, rst, wr_en, rd_en;
    reg [7:0] din;
    wire [7:0] dout;
    wire full, empty;

    // Instantiate FIFO
    async_fifo #(8, 16) uut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Generate Write and Read Clocks
    always #5 wr_clk = ~wr_clk; // 10ns period (100 MHz)
    always #8 rd_clk = ~rd_clk; // 16ns period (62.5 MHz)

    initial begin
        wr_clk = 0; rd_clk = 0; rst = 1;
        wr_en = 0; rd_en = 0; din = 8'h00;
        #20 rst = 0; // Release reset

        // Write some data
        repeat (4) begin
            #10 wr_en = 1; din = din + 1;
        end
        #10 wr_en = 0;

        // Read data after some delay
        #50;
        repeat (4) begin
            #16 rd_en = 1;
        end
        #10 rd_en = 0;

        #50 $finish;
    end
endmodule