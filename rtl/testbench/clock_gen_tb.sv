`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2025 14:19:05
// Design Name: 
// Module Name: clock_gen_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_gen_tb();

logic sys_clk;
logic rst;
logic clk_out;

clock_divider #( .N(4)) dut (
    .clk_in(sys_clk),
    .rst(rst),
    .clk_out(clk_out)
);

initial begin
    sys_clk = 0;
    forever #5 sys_clk = ~sys_clk; // 83.33 ns periyot için 41.66 ns yüksek/düşük
end


initial  begin 
    rst = 0;
    #100;
    rst = 1;
    #100;
    rst = 0;
    #10000;
    $stop();

end

endmodule
