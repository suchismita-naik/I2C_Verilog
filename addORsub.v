module addORsub(a,b,M,sum,Cy4);
input [3:0] a,b;
input M;
output [3:0] sum;
output Cy4;
wire [2:0] Cy_out;
reg state=M;
parameter add=1'b0,sub=1'b1;
always @(M) begin
  case (state)
  add: begin
    full_adder f1(.s(sum[0]),.c(Cy_out[0]),.a(a[0]),.b(b[0]),.Cin(M));
    full_adder f2(.s(sum[1]),.c(Cy_out[1]),.a(a[1]),.b(b[1]),.Cin(Cy_out[0]));
    full_adder f3(.s(sum[2]),.c(Cy_out[2]),.a(a[2]),.b(b[2]),.Cin(Cy_out[1]));
    full_adder f4(.s(sum[3]),.c(Cy4),.a(a[3]),.b(b[3]),.Cin(Cy_out[2]));
  end
  sub: begin
    full_adder f5(.s(sum[0]),.c(Cy_out[0]),.a(a[0]),.b(~b[0]),.Cin(M));
    full_adder f6(.s(sum[1]),.c(Cy_out[1]),.a(a[1]),.b(~b[1]),.Cin(Cy_out[0]));
    full_adder f7(.s(sum[2]),.c(Cy_out[2]),.a(a[2]),.b(~b[2]),.Cin(Cy_out[1]));
    full_adder f8(.s(sum[3]),.c(Cy4),.a(a[3]),.b(~b[3]),.Cin(Cy_out[2]));
  end
end
endmodule