'include "BCD.v"
'include "DFF.v"
'include "RCA.v"
'include "Clk_divider.v"

//Jaleel Created
module count10(clock,inc,reset, Count, count_eq_9)

input clock, inc, reset;
output [3:0] Count;
output count_eq_9;

DFF0 FF1 (D_in[0], clock, reset, D_out[0]);
DFF0 FF2 (D_in[1], clock, reset, D_out[1]);
DFF0 FF3 (D_in[2], clock, reset, D_out[2]);
DFF0 FF4 (D_in[3], clock, reset, D_out[3]);

wire rst;
wire [3:0] RCA_out;

four_bit_reg comp1 (RCA_out, clock, rst,count);
RCA comp2 ( count, inc, RCA_out);
assign count_eq_9= (count== 4'b1001) ? 1: 0;
assign rst= (count_eq_9 & inc) | reset;

wire [19:0] din;
wire [19:0] clkdiv;
 
DFF0 dff_inst0(
    .data_in(din[0]),
	 .clock(clock),
	 .reset(rst),
    .data_out(clkdiv[0])
);

genvar i;
generate
for (i = 1; i < 19; i=i+1) 
	begin : dff_gen_label
		 DFF0 dff_inst (
			  .data_in (din[i]),
			  .clock(clkdiv[i-1]),
			  .reset(rst),
			  .data_out(clkdiv[i])
		 );
endgenerate
endmodule
