module MUX_tb;
wire  out;
reg  a;
reg  b;
reg  c;
reg  d;
reg s0, s1;
MUX uut(.out(out), .a(a), .b(b), .c(c), .d(d), .s0(s0), .s1(s1));
 initial
 begin
 a=1'b1; b=1'b1; c=1'b1; d=1'b1;
#100
 s0=1'b0; s1=1'b0;
 #100
s0=1'b1; s1=1'b0;
 #100
s0=1'b0; s1=1'b1;
 #100
s0=1'b1; s1=1'b1;
 #100 ;
end
endmodule;
