# CSE 211 — Data Structures Term Project
## PROJ-13: Air Quality Sensor Network & Hotspot Tracker

<div align="center">
  <img src="https://yeditepe.edu.tr/themes/custom/yeditepe/logo.svg" width="120"/>
  <br><br>
  
  ![Language](https://img.shields.io/badge/Language-C++17-blue)
  ![Build](https://img.shields.io/badge/Build-Make-green)
  ![Status](https://img.shields.io/badge/Status-In%20Progress-orange)
</div>

### Proje Özeti
Bu proje, şehir genelindeki hava kalitesi sensörlerinden gelen verileri analiz eden, kirlilik odaklarını (hotspots) tespit eden ve bu odakların hareketini zaman içinde izleyen bir sistemdir. 

**Önemli Not:** Bu projede `std::vector`, `std::map` gibi STL konteynerleri yasaklanmıştır. Tüm veri yapıları (Graf, Hash Tablosu, Heap, Bağlı Liste) ekip tarafından pointer tabanlı olarak sıfırdan geliştirilmiştir.

### Grup Üyeleri ve Görev Dağılımı
* **Kişi 1:** Graf Yapısı (Graph) ve Görselleştirme
* **Kişi 2:** Hash Tablosu ve Zaman Serileri
* **Kişi 3:** Hotspot Tespit Algoritmaları (DFS/BFS)
* **Kişi 4:** Heap Yapısı ve Odak Takibi
* **Serra Pehlivanküçük (ID: 2024070211):** Entegrasyon, Dosya I/O ve Uyarı Sistemi

---

### Proje Yapısı

```text
project/
├── include/
│   ├── data_structures/  # Özelleştirilmiş Veri Yapıları (Graph, HashMap, Heap)
│   ├── core/             # Algoritmalar (HotspotDetector, AlertManager)
│   └── utils/            # Yardımcı Araçlar (DataLoader)
├── src/                  # Kaynak Kodlar (.cpp)
├── tests/                # Entegrasyon Testleri
├── data/                 # Örnek JSON Verileri
└── libs/                 # Harici Kütüphaneler (nlohmann/json)