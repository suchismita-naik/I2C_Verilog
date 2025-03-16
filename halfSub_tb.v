`timescale 1ms/1ms
module halfSub_tb();
reg a,b;
wire diff,borrow;
half_subtractor h1(.diff(diff),.borrow(borrow),.a(a),.b(b));
initial begin
  $dumpfile("halfSub_waveform.vcd");
  $dumpvars(0,halfSub_tb);
  a=0;b=0;#10;
  a=0;b=1;#10;
  a=1;b=0;#10;
  a=1;b=1;#10;
end
endmodule