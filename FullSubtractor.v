module FullSubtractor(D, Br,A,B,Cin);
input A,B,Cin;
output D,Br;
reg D,Br;
always@(A or B or Cin) begin
D = A ^ B ^ Cin;
Br = ~A & (B^Cin) | B & Cin;
end
endmodule
