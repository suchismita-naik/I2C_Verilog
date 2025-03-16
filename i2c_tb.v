`timescale 1ns/1ns
module i2c_tb;
reg clk;
reg reset;
reg start;
reg [7:0] data_in;
wire scl;
wire sda;
wire[7:0] data_out;
reg reset_n;
reg [7:0] addr;
wire ack;
wire busy;
reg reset_n;
I2C_master uut_master(.clk(clk),.reset(reset),.start(start),.data_in(data_in),.scl(scl),.sda(sda),.busy(busy));
I2C_slave uut_slave(.clk(clk),.reset_n(reset_),.sda(sda),.scl(scl),.data_out(data_out),.addr(addr),.ack(ack));
always #5 clk=~clk;
initial begin
  clk=0;
  reset=0;
  reset_n=0;
  start=0;
  addr=8'b10101010;
  data_in=8'b11001100;
  #10 reset=1;
  #10 reset=0;
  #10;
  start=1;
  #10 start=0;
  wait(!busy);
  #100;
  $finish;
end
initial begin
  $dumpfile(i2c_waveform.vcd);
  $dumpvars(0,i2c_tb);
end 
endmodule 