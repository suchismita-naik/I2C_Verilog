module top_async_fifo;
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 16;

    reg wr_clk, rd_clk, rst;   
    reg wr_en, rd_en;          
    reg [DATA_WIDTH-1:0] din;  
    wire [DATA_WIDTH-1:0] dout; 
    wire full, empty;          

    async_fifo #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) fifo_inst (
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

    // Generate Clocks
    always #5 wr_clk = ~wr_clk;  
    always #8 rd_clk = ~rd_clk;  

    // Testbench
    initial begin
        $dumpfile("waveform_fifo.vcd"); // Create VCD file for GTKWave
        $dumpvars(0, top_async_fifo); // Dump all variables

        // Initialize signals
        wr_clk = 0;
        rd_clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 8'h00;

        #20 rst = 0; 

        // Write 4 values to FIFO
        repeat (4) begin
            #10 wr_en = 1; din = din + 1;
        end
        #10 wr_en = 0;

        // Wait before reading
        #50;
        
        // Read 4 values from FIFO
        repeat (4) begin
            #16 rd_en = 1;
        end
        #10 rd_en = 0;

        // End simulation
        #100 $finish;
    end
endmodule