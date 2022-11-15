module clk_divider(clock, rst, clk_out);
input clock, rst;
output clk_out;
 
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
 
assign clk_out = clkdiv[25];
 
endmodule
