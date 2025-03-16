module top_i2c;
    reg clk;
    reg reset_n;
    wire scl;
    wire sda;
    reg [7:0] master_data;
    reg [7:0] slave_addr;
    wire [7:0] slave_data;
    wire ack;
    wire done;

    I2C_master master (
        .clk(clk),
        .reset_n(reset_n),
        .scl(scl),
        .sda(sda),
        .data_in(master_data),
        .slave_addr(slave_addr),
        .done(done)
    );

    I2C_slave slave (
        .clk(clk),
        .reset_n(reset_n),
        .scl(scl),
        .sda(sda),
        .addr(slave_addr),
        .data_out(slave_data),
        .ack(ack)
    );

    initial begin
        clk = 0;
        reset_n = 0;
        master_data = 8'hA5;
        slave_addr = 8'h50;
        #1 reset_n = 1;

        #10 $finish;
    end

    always #1 clk = ~clk;
endmodule