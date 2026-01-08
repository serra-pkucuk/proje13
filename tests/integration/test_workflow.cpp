#include <iostream>
#include <cassert>
#include "utils/DataLoader.h"
#include "data_structures/SensorGraph.h"
#include "data_structures/SensorHashMap.h"
#include "data_structures/AlertQueue.h"
#include "core/HotspotDetector.h"
#include "core/AlertManager.h"

#define ASSERT(condition, message) \
    do { \
        if (!(condition)) { \
            std::cerr << "Assertion failed: " << (message) << "\n"; \
            std::exit(1); \
        } \
    } while (false)

void test_end_to_end_workflow() {
    std::cout << "=== Entegrasyon Testi Basliyor ===\n";

    SensorGraph* graph = new SensorGraph();
    SensorHashMap* hashMap = new SensorHashMap();
    AlertPriorityQueue* alertQueue = new AlertPriorityQueue();

    std::string inputFile = "data/input_sample.json";
    
    try {
        utils::DataLoader::loadSensors(inputFile, graph, hashMap);
        utils::DataLoader::loadReadings(inputFile, hashMap);

        core::HotspotDetector detector;
        int hotspotCount = 0;
        core::Hotspot** hotspots = detector.detectHotspots(graph, 100.0, hotspotCount); 

        std::cout << "Tespit edilen hotspot sayisi: " << hotspotCount << "\n";

        core::AlertManager alertManager(alertQueue);
        alertManager.processHotspots(hotspots, hotspotCount);

        Alert* topAlert = alertQueue->extractMax();
        if (topAlert) {
            std::cout << "En kritik uyari: " << topAlert->description << "\n";
        } else {
            std::cout << "Uyari olusmadi.\n";
        }

        if (hotspots != nullptr) {
            for(int i=0; i<hotspotCount; ++i) delete hotspots[i];
            delete[] hotspots;
        }

    } catch (const std::exception& e) {
        std::cerr << "TEST HATASI: " << e.what() << "\n";
        std::exit(1);
    }

    delete graph;
    delete hashMap;
    delete alertQueue;
    
    std::cout << "=== Entegrasyon Testi Basarili ===\n";
}

int main() {
    test_end_to_end_workflow();
    return 0;
}