module half_adder (A, B,S, Co);
input A, B;
output S, Co;

assign S= A^B;
assign Co= (A&B);

endmodule

module RCA (A,Cin, S, Cout);
input [3:0] A;
output [3:0] S;
input Cin;
output Cout;

wire [2:0] C;


half_adder FA1 (A[0], Cin, S[0], C[0]);
half_adder FA2 (A[1], C[0], S[1], C[1]);
half_adder FA3 (A[2], C[1], S[2], C[2]);
half_adder FA4 (A[3], C[2], S[3], Cout);

endmodule 

module DFF0(data_in,clock,reset, data_out);
input data_in;
input clock,reset;

output reg data_out;

always@(posedge clock)
	begin
		if(reset)
			data_out<=1'b0;
		else
			data_out<=data_in;
	end	

endmodule

module four_bit_reg (D_in,clock, reset, D_out);
input [3:0] D_in;
input reset, clock;
output [3:0] D_out;

DFF0 FF1 (D_in[0], clock, reset, D_out[0]);
DFF0 FF2 (D_in[1], clock, reset, D_out[1]);
DFF0 FF3 (D_in[2], clock, reset, D_out[2]);
DFF0 FF4 (D_in[3], clock, reset, D_out[3]);

endmodule

module counter_nine (inc, reset, clock, count_eq_9, count);
input inc, reset, clock;
output count_eq_9;
output [3:0] count;

wire rst;
wire [3:0] RCA_out;

four_bit_reg comp1 (RCA_out, clock, rst,count);
RCA comp2 ( count, inc, RCA_out);
assign count_eq_9= (count== 4'b1001) ? 1: 0;
assign rst= (count_eq_9 & inc) | reset;

endmodule


module clk_divider(clock, rst, clk_in);
input clock, rst;
output clk_in;
 
wire [25:0] din;
wire [25:0] clkdiv;
 
DFF0 dff_inst0(
    .data_in(din[0]),
	 .clock(clock),
	 .reset(rst),
    .data_out(clkdiv[0])
);
 
genvar i;
generate
for (i = 1; i < 26; i=i+1) 
	begin : dff_gen_label
		 DFF0 dff_inst (
			  .data_in (din[i]),
			  .clock(clkdiv[i-1]),
			  .reset(rst),
			  .data_out(clkdiv[i])
		 );
		 end
endgenerate
 
assign din = ~clkdiv;
 
assign clk_in = clkdiv[25];
 
endmodule


module segment7 (A, B, C, D, out);
input A, B, C, D;
output [6:0] out;

assign out[0] = (~A & ~B & ~C & D)| (B &~C &~D);
assign out[1]= (B & ~C & D) | (B & C& ~D);
assign out[2]= (~B & C & ~D);
assign out[3]= (~B & ~C& D) | (B & ~C & ~D) | (B & C& D);
assign out[4]= (~A& B & ~C) | D;
assign out[5]= (C& D)| (~A & ~B & D)| (~B & C);
assign out[6]= (~A & ~B & ~C)| (B & C& D);

endmodule

module TFF0 (
data  , // Data Input
clk   , // Clock Input
reset , // Reset input
q       // Q output
);
//-----------Input Ports---------------
input data, clk, reset ; 
//-----------Output Ports---------------
output q;
//------------Internal Variables--------
reg q;
//-------------Code Starts Here---------
always @ ( posedge clk or posedge reset)
if (reset) begin
  q <= 1'b0;
end else if (data) begin
  q <= !q;
end

endmodule //End Of Module tff_async_reset
module Counter(inc, clock, reset, out1);
input inc, clock, reset;
output [6:0] out1;
wire Ceq9;

wire [3:0] count;
wire clk_in;

clk_divider Clk_div (clock, reset, clk_in);

counter_nine cnt1 (inc, reset, clk_in, Ceq9, count);

segment7 seg1 (count[3], count[2], count[1], count[0], out1);

endmodule

 