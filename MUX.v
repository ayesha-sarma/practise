module MUX ( a,  b,  c,  d,  s0, s1, out); 
input a,b,c,d,s0,s1;
output out;
 assign out = ~s1&~s0&a | ~s1&s0&b | s1&~s0&c | s1&s0&d; 
endmodule
