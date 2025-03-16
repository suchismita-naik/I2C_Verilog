`timescale 1ms/1ms
module addORsub_tb();
reg [3:0] a,b;
reg M;
wire [3:0] sum;
wire Cy4;
addORsub f1(.a(a),.b(b),.M(M),.sum(sum),.Cy4(Cy4));
initial begin
  $dumpfile("addORsub_waveform.vcd");
  $dumpvars(0,addORsub_tb);
  $monitor("time=%t::",$time,"a=%b,b=%b,M=%b,sum=%b,Cy4=%b",a,b,M,sum,Cy4);
  a=4'b0010;b=4'b1010;M=0;
  a=4'b1111;b=4'b0010;M=1;
  a=4'b1010;b=4'b1110;M=1;
end
endmodule