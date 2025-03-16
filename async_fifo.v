module async_fifo #(
    parameter DATA_WIDTH = 8,  
    parameter DEPTH = 16       
) (
    input wire wr_clk,         
    input wire rd_clk,         
    input wire rst,            
    input wire wr_en,          
    input wire rd_en,          
    input wire [DATA_WIDTH-1:0] din,  
    output reg [DATA_WIDTH-1:0] dout, 
    output reg full,           
    output reg empty           
);
    reg [DATA_WIDTH-1:0] fifo_mem [0:DEPTH-1];  
    reg [$clog2(DEPTH):0] wr_ptr = 0, rd_ptr = 0; 

    always @(posedge wr_clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            full <= 0;
        end else if (wr_en && !full) begin
            fifo_mem[wr_ptr] <= din;
            wr_ptr <= wr_ptr + 1;
            if (wr_ptr + 1 == rd_ptr)  
                full <= 1;
            empty <= 0;
        end
    end

    always @(posedge rd_clk or posedge rst) begin
        if (rst) begin
            rd_ptr <= 0;
            empty <= 1;
        end else if (rd_en && !empty) begin
            dout <= fifo_mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            if (rd_ptr + 1 == wr_ptr)  
                empty <= 1;
            full <= 0;
        end
    end
endmodule