`timescale 1ms / 1ms

module i2c_tb;
    reg clk;
    reg reset_n;
    wire scl;
    wire sda;
    reg [7:0] master_data;
    reg [7:0] slave_addr;
    wire [7:0] slave_data;
    wire ack;
    wire done;

    // Instantiate I2C Master
    I2C_master master (
        .clk(clk),
        .reset_n(reset_n),
        .scl(scl),
        .sda(sda),
        .data_in(master_data),
        .slave_addr(slave_addr),
        .done(done)
    );

    // Instantiate I2C Slave
    I2C_slave slave (
        .clk(clk),
        .reset_n(reset_n),
        .scl(scl),
        .sda(sda),
        .addr(slave_addr),
        .data_out(slave_data),
        .ack(ack)
    );

    // Clock generation
    always #1 clk = ~clk;

    initial begin
        $dumpfile("i2c_tb.vcd"); // For waveform viewing
        $dumpvars(0, i2c_tb);
        
        clk = 0;
        reset_n = 0;
        master_data = 8'hA5;   // Data to be sent by master
        slave_addr = 8'h50;    // Slave address

        #2 reset_n = 1;       // Release reset
        #20 $finish;         // Stop simulation after some time
    end
endmodule