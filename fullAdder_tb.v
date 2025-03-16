`timescale 1ms/1ms
module fullAdder_tb();
reg a,b,Cin;
wire s,c;
full_adder uut(.a(a),.b(b),.Cin(Cin),.s(s),.c(c));
initial begin
  $dumpfile("fa_waveform.vcd");
  $dumpvars(0,fullAdder_tb);
  a=0;b=0;Cin=0;#10;
  a=1;b=1;Cin=1;#10;
  a=1;b=0;Cin=0;#10;
end
endmodule