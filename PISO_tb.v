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
