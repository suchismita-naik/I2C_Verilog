module half_subtractor(output diff , borrow , input a,b);
assign diff=a^b;
assign borrow=(~a)&b;
endmodule