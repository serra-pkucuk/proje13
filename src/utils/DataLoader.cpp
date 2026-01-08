#include "utils/DataLoader.h"
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <nlohmann/json.hpp>

using json = nlohmann::json;

namespace utils {

void DataLoader::loadSensors(const std::string& filePath, SensorGraph* graph, SensorHashMap* hashMap) {
    std::ifstream file(filePath);
    if (!file.is_open()) {
        throw std::runtime_error("Dosya açılamadı: " + filePath);
    }

    json j;
    file >> j;

    if (j.contains("sensors")) {
        for (const auto& item : j["sensors"]) {
            std::string id = item["id"];
            double x = item["x"];
            double y = item["y"];
            int population = item.value("population_nearby", 0);

            graph->addSensor(id, x, y, population);
            hashMap->insert(id, x, y);
        }
    }
    
    if (j.contains("adjacency_distance")) {
        double dist = j["adjacency_distance"];
        graph->connectSensorsWithinDistance(dist); 
    }

    std::cout << "[DataLoader] " << filePath << " dosyasından sensörler yüklendi.\n";
}

void DataLoader::loadReadings(const std::string& filePath, SensorHashMap* hashMap) {
    std::ifstream file(filePath);
    if (!file.is_open()) throw std::runtime_error("Dosya açılamadı: " + filePath);

    json j;
    file >> j;

    if (j.contains("readings")) {
        for (const auto& item : j["readings"]) {
            std::string sensorId = item["sensor"];
            std::string timestamp = item["timestamp"];
            double pm25 = item.value("pm25", 0.0);
            double ozone = item.value("ozone", 0.0);
            double no2 = item.value("no2", 0.0);

            hashMap->addReading(sensorId, timestamp, pm25, ozone, no2);
        }
    }
    std::cout << "[DataLoader] Okumalar yüklendi.\n";
}

}