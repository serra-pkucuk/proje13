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

**Önemli Not:** Bu projede std::vector, std::map gibi STL konteynerleri yasaklanmıştır. Tüm veri yapıları (Graf, Hash Tablosu, Heap, Bağlı Liste) ekip tarafından pointer tabanlı olarak sıfırdan geliştirilmiştir.

### Grup Üyeleri ve Görev Dağılımı
* **Ceyda Şenay (ID: 20230702122):** Veri Yapıları Mimarı
* **Hatice Aygan (ID: 20230702004):** Zaman Serisi ve Bellek Yönetimi Uzmanı
* **Merve Naz Dikme (ID: 20240702031):** Algoritma ve Çekirdek Mantık Geliştiricisi
* **Irmak Zehra Emri (ID: 20230703016-072):** Arayüz ve Görselleştirme Geliştiricisi
* **Serra Pehlivanküçük (ID: 20240702111):** Dosya I/O, Test ve Entegrasyon Sorumlusu

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