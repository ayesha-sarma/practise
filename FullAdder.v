module FullAdder(SUM, CARRY, A, B, Cin);
input A,B,Cin;
output SUM, CARRY;
reg SUM,CARRY;
always@(A or B or Cin)
begin
CARRY = A&B | A&Cin | B&Cin;
SUM = ~A&~B&Cin | ~A&B&~Cin | A&~B&~Cin | A&B&Cin;
end
endmodule
