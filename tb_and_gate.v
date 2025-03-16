`timescale 1ms/1ms
module tb_and_gate;
reg a,b;
wire y;
and_gate uut(.a(a),.b(b),.y(y));
initial begin
  $monitor("Time=%0t|a=%b|b=%b|y=%b",$time,a,b,y);
  $dumpfile("waveform.vcd");
  $dumpvars(0,tb_and_gate);
  a=0; b=0; #10;
  a=0; b=1; #10;
  a=1; b=0; #10;
  a=1; b=1; #10;
  $finish;
end
endmodule