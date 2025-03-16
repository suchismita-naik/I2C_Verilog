module I2C_slave(
    input wire clk,
    input wire reset_n,
    input wire scl,
    inout wire sda,
    input wire [7:0] addr,
    output reg [7:0] data_out,
    output reg ack
);

parameter IDLE = 2'b00, ADDRESS_MATCH = 2'b01, RECEIVE_BYTE = 2'b10, ACKNOWLEDGE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] received_data;
reg sda_out;

assign sda = (sda_out) ? 1'bz : 0;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        state <= IDLE;
    else
        state <= next_state;
end

always @(posedge clk) begin
    case(state)
        IDLE: begin
            ack <= 0;
            if (sda == 0)  // Start condition detected
                next_state <= ADDRESS_MATCH;
        end

        ADDRESS_MATCH: begin
            if (scl) begin
                if (sda == addr[7]) 
                    next_state <= RECEIVE_BYTE;
                else 
                    next_state <= IDLE;
            end
        end

        RECEIVE_BYTE: begin
            if (scl) begin
                received_data <= {received_data[6:0], sda};
                if (received_data[7]) 
                    next_state <= ACKNOWLEDGE;
            end
        end

        ACKNOWLEDGE: begin
            ack <= 1;
            sda_out <= 0;  
            data_out <= received_data;
            next_state <= IDLE;
        end
    endcase
end

endmodule