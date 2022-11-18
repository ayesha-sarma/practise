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
