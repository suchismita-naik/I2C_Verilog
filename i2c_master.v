//code for I2C master module
module I2C_master(input wire clk,input wire reset,input wire start,input wire [7:0] data_in,output reg scl,inout wire sda,output reg busy);
integer i;
parameter IDLE=3'b000, START=3'b001, SEND_BYTE=3'b010, STOP=3'b011;
reg [2:0] state;
always @(posedge clk or posedge reset) begin
  if (reset) begin
    state<=IDLE;
    scl<=1;
    busy<=0;
  end
  else begin
    case(state)
    IDLE: begin
      if (start) begin
        state<=START;
        busy<=1;
      end
    end
    START: begin
      scl<=1;
      sda<=0;
      state<=SEND_BYTE;
    end
    SEND_BYTE: begin
      for (i=0; i<8; i=i+1) begin
        scl<=0;
        sda<=data_in[7-i];
        scl<=1;
      end
      state<=STOP;
    end
    STOP: begin
      scl<=1;
      sda<=1;
      state<=IDLE;
      busy<=0;
    end
  end
end
endmodule


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

//Top-level module to instatiate master and slave
module top;
reg clk;
reg reset;
reg start;
reg [7:0] data_in;
wire scl;
wire sda;
wire busy;
reg [7:0] addr;
wire ack;
reg reset_n;
I2C_master master(.clk(clk),.reset(reset),.start(start),.data_in(data_in),.scl(scl),.sda(sda),.busy(busy));
I2C_slave slave(.clk(clk),.reset_n(reset_n),.sda(sda),.scl(scl),.data_out(),.addr(addr),.ack(ack));
always begin
  #5 clk=~clk;
end
initial begin
  clk=0;
  reset=0;
  start=0;
  data_in=8'b10101010;
  addr=8'b00010001;
  reset_n=0;
  #10 reset=1;
  #10 reset=0;
  #10 start=1;
  #10 start=0;
  #100;
  $finish;
end
endmodule