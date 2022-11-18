module HalfAdder_tb;
reg A;
reg B;
wire SUM;
wire CARRY;
HalfAdder uut ( .A(A),.B(B),.SUM(SUM), .CARRY(CARRY));
initial begin
A=1'b0;B=1'b0;                      
#200A=1'b0;B=1'b1;                       
#200A=1'b1;B=1'b0;                      
#200A=1'b1;B=1'b1;                      
#200 $stop;
end
endmodule
