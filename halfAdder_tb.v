`timescale 1ms/1ms
module halfAdder_tb();
reg x,y;
wire m,n;
half_adder uut(.a(x),.b(y),.sum(m),.carry(n));
initial begin
  $dumpfile("ha_waveform.vcd");
  $dumpvars(0,halfAdder_tb);
  x=0;y=0;#10;
  x=0;y=1;#10;
  x=1;y=0;#10;
  x=1;y=1;#10;
  //$finish;
end
endmodule