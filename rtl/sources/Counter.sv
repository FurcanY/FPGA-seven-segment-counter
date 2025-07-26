`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Furkan Yıldırım
// 
// Create Date: 22.07.2025 20.35
// Design Name: 0-999 counter design
// 
//////////////////////////////////////////////////////////////////////////////////

/*
    Ortak Anot 7 Segment Display
    
    [6:0] data = a,b,c,d,e,f,g -> seven segment display
    
    show 0    -> 7'b0000001 (Ortak katotun tersi)
    show 1    -> 7'b1001111 
    show 2    -> 7'b0010010
    show 3    -> 7'b0000110
    show 4    -> 7'b1001100
    show 5    -> 7'b0100100
    show 6    -> 7'b0100000
    show 7    -> 7'b0001111
    show 8    -> 7'b0000000
    show 9    -> 7'b0000100

    segment0_counter = birler basamagi
    segment1_counter = onlar  basamagi
    segment2_counter = yuzler basamagi
    
    
    12.000.000MHz Cmod A7 35T 
    saniyede 60 kere değişmesini istiyoruz
    12.000.000 / 60 = 200.000 sayması gerekli 
    2^12
    
*/


module Counter(
    input  logic btn,       // Sayaç artırmak için buton girişi
    input  logic rst,       // Sıfırlama sinyali
    input  logic sysclk,    // 12 MHz sistem saati
    output logic [6:0] data,    // 7 segment display için veri çıkışı
    output logic [2:0] select   // Hangi hanenin aktif olacağını seçer
);

// düşük frekanslı saat sinyali
wire divided_clock;

// Segment verisini geçici olarak tutan sinyal
logic [6:0] data_internal;

// Saat bölücü modülü örneği ( yaklaşım 186ms )
clock_divider #( .N(16) ) clk_div(
    .clk_in(sysclk),          // Giriş saati
    .clk_out(divided_clock),  // Çıkış (bölünmüş) saat
    .rst(rst)                 // Reset sinyali
);

// Buton ve reset girişlerinin sistem saatine senkronlanması
// (Metastabiliteyi önlemek için iki flip-flop)
logic btn_sync1, btn_sync2;
logic rst_sync1, rst_sync2;

always_ff @(posedge sysclk) begin
    btn_sync1 <= btn;
    btn_sync2 <= btn_sync1;  
end

always_ff @(posedge sysclk) begin
    rst_sync1 <= rst;
    rst_sync2 <= rst_sync1;  
end

// 0-999 arası sayacı ve basamak değerleri
logic [9:0] counter;      
logic [3:0] hundreds;     
logic [3:0] tens;         
logic [3:0] ones;         

// Sayacın artışı ve sıfırlanması (butonla tetikleniyor)
always_ff @ (posedge sysclk) begin
    if ( rst_sync2 ) begin
        counter <= 0;  
    end
    else begin
        
        if (btn_sync2 == 1'b1 && btn_sync1 == 1'b0) begin
            if (counter == 10'd999)
                counter <= 0;  
            else
                counter <= counter + 1;
        end
    end
end

// Hangi hanenin gösterileceğini belirleyen seçici (multiplexing)
// Her clock döngüsünde bir sonraki haneye geçilir
always_ff @(posedge divided_clock or posedge rst_sync2) begin
    if (rst_sync2)
        select <= 3'b001;  
    else begin
        case (select)
            3'b001: select <= 3'b010; 
            3'b010: select <= 3'b100; 
            3'b100: select <= 3'b001; 
            default: select <= 3'b001; 
        endcase
    end
end

// Her bir basamağın segment koduna çevrilmesi (BCD'den 7 segment'e)
// Gösterilecek haneye göre uygun değeri gösterir
always_comb begin
    hundreds = counter / 100;
    tens     = (counter / 10) % 10;
    ones     = counter % 10;

    case (select)
        3'b001: data_internal = get_segment_code(ones);     // birler
        3'b010: data_internal = get_segment_code(tens);     // onlar
        3'b100: data_internal = get_segment_code(hundreds); // yüzler
        default: data_internal = 7'b1111111; // Hepsi kapalı (ortak anot)
    endcase
end

// Segment çıkışı olarak iç veriyi ata
assign data = data_internal;

endmodule


// seven segment veri dönüşümü
function logic [6:0] get_segment_code (input logic [3:0] data);
    case (data)
        4'b0000: get_segment_code = 7'b0000001; // 0 
        4'b0001: get_segment_code = 7'b1001111; // 1 
        4'b0010: get_segment_code = 7'b0010010; // 2
        4'b0011: get_segment_code = 7'b0000110; // 3
        4'b0100: get_segment_code = 7'b1001100; // 4
        4'b0101: get_segment_code = 7'b0100100; // 5
        4'b0110: get_segment_code = 7'b0100000; // 6
        4'b0111: get_segment_code = 7'b0001111; // 7
        4'b1000: get_segment_code = 7'b0000000; // 8 
        4'b1001: get_segment_code = 7'b0000100; // 9
        default: get_segment_code = 7'b1111111; 
    endcase
endfunction