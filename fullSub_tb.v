`timescale 1ms/1ms
module fullSub_tb();
reg a,b,Bin;
wire diff,Bout;
full_subtractor h2(.diff(diff),.Bout(Bout),.a(a),.b(b),.Bin(Bin));
initial begin
  $dumpfile("fullSub_waveform.vcd");
  $dumpvars(0,fullSub_tb);
  
  a=0;b=0;Bin=0;#10;
  a=0;b=0;Bin=1;#10;
  a=0;b=1;Bin=0;#10;
  a=0;b=1;Bin=1;#10;
  a=1;b=0;Bin=0;#10;
  a=1;b=0;Bin=1;#10;
  a=1;b=1;Bin=0;#10;
  a=1;b=1;Bin=1;#10;
end
endmodule