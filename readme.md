# FPGA Seven Segment Counter

**Basit bir FPGA projesi:** 0'dan 999'a kadar sayan, ortak-anotlu 3 haneli 7 segment display kullanan sayıcı.




## Dosyalar
- Counter.v – Ana modül
- clock_divider.v – 12 MHz → ~60 Hz bölücü (parametrik)

## Özellikler
- **Kart:** Digilent Cmod A7-35T (12 MHz)
- **Buton:** Her basışta sayı 1 artar (999'dan sonra 0’a döner)
- **Reset:** Sıfırlama
- **Multiplexing:** 3 hane sırayla yakılarak gösterilir (~180 Hz)

| Sinyal        | FPGA Pini (Cmod A7) | Açıklama              |
| ------------- | ------------------- | --------------------- |
| `btn`         | JB1 (SW1)           | Sayaç artır           |
| `rst`         | JB2 (SW2)           | Reset                 |
| `sysclk`      | A7                  | 12 MHz osilatör       |
| `data[6:0]`   | C1-C7               | Seven segment verileri |
| `select[2:0]` | A1-A3               | Segment seçimi           |

---

![image_01](./image_01.png)

![image_02](./image_02.png)




## Projeden Öğrendiklerim
- Metastabiliteyi önlemek → 2 kademeli synchronizer ile buton/reset girişlerini senkronize etmek
- Clock kullanımı → 12 MHz sistem saatini clock divider ile ~60 Hz’e indirerek çoklamalı display’i çalıştırmak
