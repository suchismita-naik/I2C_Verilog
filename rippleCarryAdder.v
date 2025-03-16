module rippleCarryAdder(sum,Cy4,a,b,Cy_in);
input [3:0] a,b;
input Cy_in;
output [3:0] sum;
output Cy4;
wire [2:0] Cy_out;
full_adder f1(.s(sum[0]),.c(Cy_out[0]),.a(a[0]),.b(b[0]),.Cin(Cy_in));
full_adder f2(.s(sum[1]),.c(Cy_out[1]),.a(a[1]),.b(b[1]),.Cin(Cy_out[0]));
full_adder f3(.s(sum[2]),.c(Cy_out[2]),.a(a[2]),.b(b[2]),.Cin(Cy_out[1]));
full_adder f4(.s(sum[3]),.c(Cy4),.a(a[3]),.b(b[3]),.Cin(Cy_out[2]));
endmodule