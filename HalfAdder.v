module HalfAdder(SUM, CARRY, A, B);
input A,B;
output SUM, CARRY;
reg SUM,CARRY;
always@(A or B) begin
SUM = A^B;
CARRY = A&B;
end
endmodule
