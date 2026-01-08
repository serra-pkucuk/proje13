#pragma once
#include "data_structures/AlertQueue.h"
#include "core/Hotspot.h"

namespace core {

class AlertManager {
public:
    AlertManager(AlertPriorityQueue* queue);
    void processHotspots(Hotspot** hotspots, int count);

private:
    AlertPriorityQueue* alertQueue;
    int calculateAlertPriority(Hotspot* hotspot);
};

}