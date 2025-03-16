module fa_ha(output sum,carry,input a,b,Cin);
wire w1,w2,w3;
half_adder h1(.a(a),.b(b),.sum(w1),.carry(w2));
half_adder h2(.a(w1),.b(Cin),.sum(sum),.carry(w3));
or g1(carry,w2,w3);
endmodule