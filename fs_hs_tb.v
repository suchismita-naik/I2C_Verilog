`timescale 1ms/1ms
module fs_hs_tb();
reg a,b,Bin;
wire diff,Bout;
fs_hs h4(.a(a),.b(b),.Bin(Bin),.diff(diff),.Bout(Bout));
initial begin
  $dumpfile("fs_hs_waveform.vcd");
  $dumpvars(0,fs_hs_tb);
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