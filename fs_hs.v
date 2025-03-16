module fs_hs(output diff,Bout,input a,b,Bin);
wire w1,w2,w3;
half_subtractor  h1(.a(a),.b(b),.diff(w1),.borrow(w2));

half_subtractor h2(.a(w1),.b(Bin),.diff(diff),.borrow(w3));

or h3(Bout,w2,w3);
endmodule