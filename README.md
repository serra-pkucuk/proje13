# CSE 211 - Data Structures Term Project
## PROJ-13: Air Quality Sensor Network & Hotspot Tracker

### Proje Ozeti
Bu proje, sehir genelindeki hava kalitesi sensorlerinden gelen verileri analiz eden, kirlilik odaklarini (hotspots) tespit eden ve bu odaklarin hareketini zaman icinde izleyen bir sistemdir.

**Onemli Not:** Bu projede std::vector, std::map gibi STL konteynerleri yasaklanmistir. Tum veri yapilari (Graf, Hash Tablosu, Heap, Bagli Liste) ekip tarafindan pointer tabanli olarak sifirdan gelistirilmistir.

### Grup Uyeleri ve Gorev Dagilimi
* **Kisi 1:** Graf Yapisi (Graph) ve Gorsellestirme
* **Kisi 2:** Hash Tablosu ve Zaman Serileri
* **Kisi 3:** Hotspot Tespit Algoritmalari (DFS/BFS)
* **Kisi 4:** Heap Yapisi ve Odak Takibi
* **Serra Pehlivankucuk (ID: 2024070211):** Entegrasyon, Dosya I/O ve Uyari Sistemi (Bu Repo)

---

### Proje Yapisi

project/
├── include/
│   ├── data_structures/  # Ozellestirilmis Veri Yapilari (Graph, HashMap, Heap)
│   ├── core/             # Algoritmalar (HotspotDetector, AlertManager)
│   └── utils/            # Yardimci Araclar (DataLoader)
├── src/                  # Kaynak Kodlar (.cpp)
├── tests/                # Entegrasyon Testleri
├── data/                 # Ornek JSON Verileri
└── libs/                 # Harici Kutuphaneler (nlohmann/json)

### Kurulum ve Calistirma

Bu projeyi calistirmak icin terminalde su komutlari sirasiyla uygulayin:

1. Bagimliliklari Yukle (JSON Kutuphanesi):
make deps

2. Projeyi Derle:
make

3. Calistir:
make run

4. Testleri Calistir:
make test

### Kullanilan Ozel Veri Yapilari
STL yerine asagidakiler implemente edilmistir:
1. **SensorGraph:** Adjacency List (Linked List tabanli) kullanan uzamsal ag.
2. **SensorHashMap:** Chaining Yontemi ile pointer tabanli hash tablosu.
3. **AlertPriorityQueue:** Pointer tabanli Min-Heap agaci.

---
CSE 211 - Fall 2025-2026