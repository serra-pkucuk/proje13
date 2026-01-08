#pragma once
#include <string>
#include "data_structures/SensorGraph.h"
#include "data_structures/SensorHashMap.h"

namespace utils {

class DataLoader {
public:
    static void loadSensors(const std::string& filePath, SensorGraph* graph, SensorHashMap* hashMap);
    static void loadReadings(const std::string& filePath, SensorHashMap* hashMap);
};

}