module i2c_top (
    input wire clk,
    input wire reset_n,
    inout wire sda,
    output wire scl
);
    
    wire [7:0] slave_data;
    wire ack;
    reg [7:0] master_data = 8'hA5;  // Example data to send
    reg [6:0] slave_addr = 7'h50;   // Example slave address

    I2C_master master (
        .clk(clk),
        .reset_n(reset_n),
        .scl(scl),
        .sda(sda),
        .data_in(master_data),
        .slave_addr(slave_addr),
        .done()
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

endmodule