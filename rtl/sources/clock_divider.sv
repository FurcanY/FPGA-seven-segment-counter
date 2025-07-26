`timescale 1ns / 1ps



module clock_divider(
  input  wire clk_in,    // 12 MHz ana saat
  input  wire rst,       // asenkron reset
  output reg  clk_out    // bölünmüş saat
);
  parameter N = 20;      // sayaç genişliği (20‑bit)
  reg [N-1:0] counter;

  always @(posedge clk_in or posedge rst) begin
    if (rst)
      counter <= 0;
    else
      counter <= counter + 1;
  end

  // bütün bitler 1 olursa çıkış sinyali ver
  assign clk_out = (counter == {N{1'b1}});
endmodule