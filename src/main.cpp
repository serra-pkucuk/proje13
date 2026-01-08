#include <iostream>
#include <string>
#include <vector>
#include "utils/DataLoader.h"
#include "data_structures/SensorGraph.h"
#include "data_structures/SensorHashMap.h"
#include "data_structures/AlertQueue.h"
#include "core/HotspotDetector.h"
#include "core/AlertManager.h"

void printUsage() {
    std::cout << "Kullanim: ./main [veri_dosyasi] [esik_deger]\n";
    std::cout << "Ornek: ./main data/input_sample.json 100\n";
}

int main(int argc, char* argv[]) {
    std::string inputFile = "data/input_sample.json";
    double threshold = 100.0;

    if (argc > 1) inputFile = argv[1];
    if (argc > 2) threshold = std::stod(argv[2]);

    std::cout << "==========================================\n";
    std::cout << "   HAVA KALITESI TAKIP SISTEMI (PROJ-13)  \n";
    std::cout << "==========================================\n";
    std::cout << "Veri Dosyasi : " << inputFile << "\n";
    std::cout << "Esik Deger   : " << threshold << " AQI\n\n";

    SensorGraph* graph = new SensorGraph();
    SensorHashMap* hashMap = new SensorHashMap();
    AlertPriorityQueue* alertQueue = new AlertPriorityQueue();

    try {
        std::cout << "[1/4] Veriler yukleniyor...\n";
        utils::DataLoader::loadSensors(inputFile, graph, hashMap);
        utils::DataLoader::loadReadings(inputFile, hashMap);
        std::cout << "      -> Veri yukleme tamamlandi.\n";

        std::cout << "[2/4] Kirlilik odaklari tespit ediliyor...\n";
        core::HotspotDetector detector;
        int hotspotCount = 0;
        
        core::Hotspot** hotspots = detector.detectHotspots(graph, threshold, hotspotCount);
        
        std::cout << "      -> Tespit edilen odak sayisi: " << hotspotCount << "\n";

        std::cout << "[3/4] Risk analizi ve uyari yonetimi yapiliyor...\n";
        core::AlertManager alertManager(alertQueue);
        alertManager.processHotspots(hotspots, hotspotCount);

        std::cout << "[4/4] Sistem durumu raporlaniyor...\n";
        Alert* topAlert = alertQueue->extractMax();
        if (topAlert) {
            std::cout << "      [KRITIK UYARI]: " << topAlert->description 
                      << " (Bolge: " << topAlert->hotspotID << ")\n";
        } else {
            std::cout << "      Aktif kritik uyari bulunmuyor.\n";
        }

        if (hotspots != nullptr) {
            for (int i = 0; i < hotspotCount; ++i) {
                delete hotspots[i];
            }
            delete[] hotspots;
        }

    } catch (const std::exception& e) {
        std::cerr << "\n[HATA]: Program calisirken bir sorun olustu:\n" 
                  << e.what() << "\n";
        delete graph;
        delete hashMap;
        delete alertQueue;
        return 1;
    }

    delete graph;
    delete hashMap;
    delete alertQueue;

    std::cout << "\n==========================================\n";
    std::cout << "   Sistem basariyla kapatildi.\n";
    std::cout << "==========================================\n";
    
    return 0;
}