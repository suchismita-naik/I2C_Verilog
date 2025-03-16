`timescale 1ms/1ms
module rippleCarryAdder_tb();
reg [3:0] a,b;
reg Cy_in;
wire [3:0] sum;
wire Cy4;
rippleCarryAdder r1(.a(a),.b(b),.Cy_in(Cy_in),.sum(sum),.Cy4(Cy4));
initial begin
  $dumpfile("rca_waveform.vcd");
  $dumpvars(0,rippleCarryAdder_tb);
  $monitor("time=%t::",$time,"a=%b,b=%b,Cy_in=%b,sum=%b,Cy4=%b",a,b,Cy_in,sum,Cy4);
  a=4'b1111;b=4'b1111;Cy_in=0;#10;
  a=4'b0100;b=4'b1011;Cy_in=0;#10;
  a=4'b1000;b=4'b0111;Cy_in=0;#10;
  a=4'b0011;b=4'b1100;Cy_in=0;#10;
  a=4'b1010;b=4'b0101;Cy_in=0;#10;
  //$monitor("time=%t::",$time,"a=%b,b=%b,Cy_in=%b,sum=%b,Cy4=%b",a,b,Cy_in,sum,Cy4);
end
endmodule