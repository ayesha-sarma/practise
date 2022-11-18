1.(a)Counter
module up_counter(input clk, reset, output[3:0] counter);
reg [3:0] counter_up;
always @(posedge clk or posedge reset)
begin
if(reset)
 counter_up <= 4'd0;
else
 counter_up <= counter_up + 4'd1;
end 
assign counter = counter_up;
endmodule

1.(b)Counter_tb
module upcounter_testbench();
reg clk, reset;
wire [3:0] counter;

up_counter dut(clk, reset, counter);
initial begin 
clk=0;
forever #5 clk=~clk;
end
initial begin
reset=1;
#20;
reset=0;
end
endmodule

2.(a)PISO
module PISO(CLK,D,Q,SHIFT_LOAD);
input CLK, SHIFT_LOAD;
input [3:0]D;
output Q;
reg Q;
reg [3:0]TEMP;
always@(posedge CLK)
begin
if(SHIFT_LOAD==1'b0)
begin
Q<=1'b0;
TEMP<=D;
end
else
begin
Q<=TEMP[0];
TEMP<= TEMP>>1'b1;
end
end
endmodule

2.(b)PISO_tb
module PISO_tb;
reg CLK, SHIFT_LOAD;
reg [3:0] D;
wire Q;
PISO uut (.CLK(CLK), 
.D(D), 
.Q(Q), 
.SHIFT_LOAD(SHIFT_LOAD) );
initial CLK=1'b1;
always #100 CLK=~CLK;
initial begin
D=4'b1101; SHIFT_LOAD = 1'b0;
#200 ;
SHIFT_LOAD = 1'b1;
#1200;
D=4'b1001; SHIFT_LOAD = 1'b0;
#200 ;
SHIFT_LOAD = 1'b1;
#1000 $stop;
end
endmodule

3.(a)Full adder[gate level]
module FullAdder(SUM, CARRY, A, B, Cin);
input A,B,Cin;
output SUM, CARRY;
wire W1,W2,W3,W4;
xor G1(W1,A,B);
xor G2(SUM,W1,Cin);
and G3(W2,A,Cin);
and G4(W3,B,Cin);
and G5(W4,A,B);
or G6(CARRY,W2,W3,W4);
endmodule

3.(b)Full adder_tb[common]
module FullAdder_tb;
reg A;
reg B;
reg Cin;
wire SUM;
wire CARRY;
FullAdder uut (
.SUM(SUM), 
.CARRY(CARRY), 
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
 
3.(c)FullAdder[dataflow]
module FullAdder(SUM, CARRY, A, B, Cin);
input A,B,Cin;
output SUM, CARRY;
assign CARRY=A&B | A&Cin | B&Cin;
assign SUM = ~A&~B&Cin | ~A&B&~Cin | A&~B&~Cin | A&B&Cin;
endmodule

3.(d)FullAdder[Behaviour]
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

4.Half-Adder[gate]
module HalfAdder(SUM, CARRY, A, B);
input A,B;
output SUM, CARRY;
xor G1(SUM,A,B);
and G5(CARRY,A,B);
endmodule

4.(b)HalfAdder_tb[common]
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

4.(c)HalfAdder[data]
module HalfAdder(SUM, CARRY, A, B);
input A,B;
output SUM, CARRY;
assign SUM = A^B;
assign CARRY = A&B;
endmodule

4.(d)HalfAdder[behav]
module HalfAdder(SUM, CARRY, A, B);
input A,B;
output SUM, CARRY;
reg SUM,CARRY;
always@(A or B) begin
SUM = A^B;
CARRY = A&B;
end
endmodule

5.(a)FullSubtractor[data]
module FullSubtractor(D, Br,A,B,Cin);
input A,B,Cin;
output D,Br;
assign D = A ^ B ^ Cin;
assign Br = ~A & (B^Cin) | B & Cin;
endmodule

5.(b)FullSubtractor[tb]
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
 
5.(c)FUullSubtractor[gate]
module FullSubtractor(D, Br, A, B, Cin);
input A,B,Cin;
output D, Br;
wire W1,W2,W3,W4,W5;
xor G1(W1,A,B);
xor G2(D,W1,Cin);
not G7(W5,W1);
not G8(W6,A);
and G4(W3,W5,Cin);
and G5(W4,W6,B);
or G6(Br,W3,W4);
endmodule

5.(d)FullSubtractor[behav]
module FullSubtractor(D, Br,A,B,Cin);
input A,B,Cin;
output D,Br;
reg D,Br;
always@(A or B or Cin) begin
D = A ^ B ^ Cin;
Br = ~A & (B^Cin) | B & Cin;
end
endmodule

6.(a)MUX
module MUX ( a,  b,  c,  d,  s0, s1, out); 
input a,b,c,d,s0,s1;
output out;
 assign out = ~s1&~s0&a | ~s1&s0&b | s1&~s0&c | s1&s0&d; 
endmodule

6.(b)MUX_tb
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
endmodule

7.(a)SR
module SR_FF(Q,QB,S,R,CLK);
input S,R,CLK;
output Q,QB;
reg Q,QB;
always @(posedge CLK)
begin
case({S,R})
2'b00:Q=Q;
2'b01:Q=0;
2'b10:Q=1;
2'b11:Q=1'bx;
endcase 
QB=~Q;
end
endmodule

7.(b)SR_tb
module SR_FF_TB;

reg S;
reg R;
reg CLK;
wire Q;
wire QB;
SR_FF uut (
.Q(Q), 
.QB(QB), 
.S(S), 
.R(R), 
.CLK(CLK)
);
always #100 CLK=~CLK;
initial begin
CLK=1;
#200 S=1; R=0;
#200 S=0; R=0;
#200 S=0; R=1;
#200 S=1; R=1;
end 
endmodule

8.(a)JK
module JK_FF(Q,QB,J,K,CLK);
input J,K,CLK;
output Q,QB;
reg Q,QB;
always @(posedge CLK)
begin
case({J,K})
2'b00:Q=Q;
2'b01:Q=0;
2'b10:Q=1;
2'b11:Q=~Q;
endcase 
QB=~Q;
end
endmodule

8.(b)JK_tb
module JK_FF_TB;
reg J;
reg K;
reg CLK;
wire Q;
wire QB;
JK_FF uut (
.Q(Q), 
.QB(QB), 
.J(J), 
.K(K), 
.CLK(CLK)
);
always #100 CLK=~CLK;
initial begin
CLK=1;
#200 J=1;K=0;
#200 J=0; K=0;
#200 J=0; K=1;
#200 J=1; K=1;
end 
endmodule

9.(a)D
module D_FF(Q,QB,D,CLK);
input D,CLK;
output Q,QB;
reg Q,QB;
always @(posedge CLK)
begin
Q=D; 
QB=~Q;
end
endmodule

9.(b)D_tb
module D_FF_TB;
reg D;
reg CLK;
wire Q;
wire QB;
D_FF uut (
.Q(Q), 
.QB(QB), 
.D(D), 
.CLK(CLK)
);
always #100 CLK=~CLK;
initial begin
CLK=1;
#200 D=1;
#200 D=0;
end 
endmodule

10.(a)T
module T_FF(Q,QB,T,CLK);
input T,CLK;
output Q,QB;
reg Q=0,QB;
always @(posedge CLK)
begin
case(T)
1'b0:Q=Q;
1'b1:Q=~Q;
endcase
QB=~Q;
end
endmodule

10.(b)T_tb
module T_FF_TB;
reg T;
reg CLK;
wire Q;
wire QB;
T_FF uut (
.Q(Q), 
.QB(QB), 
.T(T), 
.CLK(CLK)
);
always #100 CLK=~CLK;
initial begin
CLK=1;
#200 T=0;
#200 T=1;
#200 T=0;
#200 T=1;
end 
endmodule

