'include "BCD.v"
'include "DFF.v"
'include "RCA.v"
'include "Clk_divider.v"

//Jaleel Created
module count10(clock,inc,reset, Count, count_eq_9)

input clock, inc, reset;
output [3:0] Count;
output count_eq_9;

DFF0 FF1 (Count[0], clock, reset, count_eq_9[0]);
DFF0 FF2 (Count[1], clock, reset, count_eq_9[1]);
DFF0 FF3 (Count[2], clock, reset, count_eq_9[2]);
DFF0 FF4 (Count[3], clock, reset, count_eq_9[3]);

wire rst;
wire [3:0] RCA_out;

four_bit_reg comp1 (RCA_out, clock, rst,count);
RCA comp2 ( count, inc, RCA_out);
assign count_eq_9= (count== 4'b1001) ? 1: 0;
assign rst= (count_eq_9 & inc) | reset;

endmodule
