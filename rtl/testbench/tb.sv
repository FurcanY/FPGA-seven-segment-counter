`timescale 1ns / 1ps

module tb();


logic btn;
logic rst;
logic sysclk;
logic [6:0] data;
logic [2:0] select;
     
Counter dut(
    .btn(btn),
    .rst(rst),
    .sysclk(sysclk),
    .data(data),
    .select(select)
);


  // Clock üretimi (12 MHz ≈ 83.33 ns periyot)
  initial begin
    sysclk = 0;
    forever #5 sysclk = ~sysclk; // 83.33 ns periyot için 41.66 ns yüksek/düşük
  end
  
  // Test senaryosu
  initial begin
    $display("Test basladi");
    
    // Başlangıç değerleri
    btn = 0;
    rst = 1;
    #10;
    rst = 0;
    #200;
    rst = 1;
    #10;
    rst = 0;
    #100;

    // Butona bas – sayaç artmalı
    repeat (1000) begin
      btn = 1;
      #10; 
      btn = 0;
      #10; // Buton bırakılır
    end

    $display("Test tamamlandı");
    $stop;
  end


endmodule
