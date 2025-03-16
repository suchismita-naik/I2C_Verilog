//code for I2C slave module
module I2C_slave(clk,reset_n,sda,scl,data_out,addr,ack);
input clk, reset_n, scl;
input [7:0] addr;
inout wire sda;
output reg[7:0] data_out;
output reg ack;
parameter IDLE=3'b000;
parameter ADDRESS_MATCH=3'b001;
parameter RECEIVE_BYTE=3'b010;
parameter ACKNOWLEDGE=3'b011;
reg [2:0] state;
reg [2:0] next_state;
reg [7:0] received_data;
reg [7:0] address;
reg sda_out;
assign sda = (sda_out) ? 1'bz : 0;
always @(posedge clk or negedge reset_n) begin
  if (!reset_n)
  state<=IDLE;
  else
  state<=next_state;
end
always @(*) begin
  case(state)
  IDLE:begin
    ack<=0;
    if (sda==0)
    next_state<=ADDRESS_MATCH;
    else
    next_state<=IDLE;
  end
  ADDRESS_MATCH: begin
    if (scl==1) begin
      if (sda==addr[7])
      next_state<=RECEIVE_BYTE;
      else
      next_state<=IDLE;
    end
  end
  RECEIVE_BYTE: begin
    if (scl==1) begin
      received_data<={received_data[6:0],sda};
    end
    if (received_data[7]==1)
    next_state<=ACKNOWLEDGE;
    else
    next_state<=RECEIVE_BYTE;
  end
  ACKNOWLEDGE: begin
    ack<=1;
    sda_out<=0;
    data_out<=received_data;
    next_state<=IDLE;
  end
  default:
  next_state<=IDLE;
  endcase
end
endmodule