module full_subtractor(output diff,Bout,input a,b,Bin);
assign diff=a^b^Bin;
assign Bout=((~a)&b)|((~a)&Bin)|(b&Bin);
endmodule