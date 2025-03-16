`timescale 1ms/1ms
module fa_ha_tb();
reg a,b,Cin;
wire sum,carry;
fa_ha uut(.a(a),.b(b),.Cin(Cin),.sum(sum),.carry(carry));
initial begin
  $dumpfile("fa_ha_waveform.vcd");
  $dumpvars(0,fa_ha_tb);
  a=0;b=0;Cin=0;#10;
  a=1;b=1;Cin=1;#10;
  a=1;b=0;Cin=0;#10;
end
endmodule