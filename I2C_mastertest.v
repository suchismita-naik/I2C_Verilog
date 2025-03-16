module I2C_master(
    input wire clk,
    input wire reset_n,
    output reg scl,
    inout wire sda,
    input wire [7:0] data_in,
    input wire [7:0] slave_addr,
    output reg done
);

parameter IDLE = 2'b00, START = 2'b01, SEND_ADDR = 2'b10, SEND_DATA = 2'b11;
reg [1:0] state, next_state;
reg [7:0] data_to_send;
reg [3:0] bit_count;
reg sda_out;
assign sda = (sda_out) ? 1'bz : 0;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        state <= IDLE;
    else
        state <= next_state;
end

always @(posedge clk) begin
    case (state)
        IDLE: begin
            scl <= 1;
            sda_out <= 1;
            done <= 0;
            bit_count <= 0;
            if (data_in != 8'b0)  
                next_state <= START;
        end

        START: begin
            sda_out <= 0;  // Start condition
            scl <= 0;
            data_to_send <= {slave_addr, 1'b0}; // LSB = 0 for write
            next_state <= SEND_ADDR;
        end

        SEND_ADDR: begin
            if (bit_count < 8) begin
                sda_out <= data_to_send[7];
                data_to_send <= {data_to_send[6:0], 1'b0}; // Shift left
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 0;
                next_state <= SEND_DATA;
            end
        end

        SEND_DATA: begin
            if (bit_count < 8) begin
                sda_out <= data_in[7];
                data_to_send <= {data_in[6:0], 1'b0};
                bit_count <= bit_count + 1;
            end else begin
                done <= 1;
                next_state <= IDLE;
            end
        end
    endcase
end

endmodule