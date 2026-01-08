#include "core/AlertManager.h"
#include <iostream>
#include <string>

namespace core {

AlertManager::AlertManager(AlertPriorityQueue* queue) : alertQueue(queue) {}

void AlertManager::processHotspots(Hotspot** hotspots, int count) {
    for (int i = 0; i < count; ++i) {
        Hotspot* hs = hotspots[i];

        if (hs->maxAQI > 100) {
            int priority = calculateAlertPriority(hs);
            
            Alert* newAlert = new Alert();
            newAlert->hotspotID = hs->id;
            newAlert->description = "Tehlikeli seviye: " + std::to_string(hs->maxAQI);
            newAlert->timestamp = "Guncel";
            
            alertQueue->insert(newAlert, priority);
            
            std::cout << "[AlertManager] Uyari eklendi. Oncelik: " << priority << "\n";
        }
    }
}

int AlertManager::calculateAlertPriority(Hotspot* hotspot) {
    int priority = 0;
    
    priority += hotspot->maxAQI * 2;
    priority += hotspot->affectedPopulation;
    priority += hotspot->durationMinutes / 10;
    
    if (hotspot->trend == Trend::RISING) {
        priority = static_cast<int>(priority * 1.5);
    }
    
    return priority;
}

}