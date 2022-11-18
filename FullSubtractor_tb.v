module FullSubtractor_tb;
reg A;
reg B;
reg Cin;
wire D;
wire Br;
FullSubtractor uut (
.D(D), 
.Br(Br), 
.A(A), 
.B(B), 
.Cin(Cin)
);
initial begin
A = 0; B = 0; Cin = 0;
#100;
A = 0; B = 0; Cin = 1;
#100;
A = 0; B = 1; Cin = 0;
#100;
A = 0; B = 1; Cin = 1;
#100;
A = 1; B = 0; Cin = 0;
#100;
A =1; B = 0; Cin = 1;
#100;
A = 1; B = 1; Cin = 0;
#100;
A = 1; B = 1; Cin = 1;
#100;
end
 endmodule
