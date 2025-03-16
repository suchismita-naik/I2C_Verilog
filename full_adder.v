module full_adder(output s,c,input a,b,Cin);
assign s=a^b^Cin;
assign c=(a&b)|(b&Cin)|(a&Cin);
endmodule